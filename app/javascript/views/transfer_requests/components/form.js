$(document).ready(function(){
  let truckload
  let balance_value_truckload
  let formatted_balance_value
  let agent_bank_account
  let driver_bank_account

  $('.truckloads-select').change(function(){
    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/transfer_requests/truckload_information',
      async: false,
      data: { id: this.value }
    }).done(function(data){
      truckload = data['truckload']
      balance_value_truckload = data['balance_value_truckload']
      formatted_balance_value = data['formatted_balance_value_truckload']
      agent_bank_account = data['agent_bank_account']
      driver_bank_account = data['driver_bank_account']
    })

    $('#use_available').change(function () {
      if (this.checked) {
        $('#transfer_request_value').val(balance_value_truckload)
      } else {
        $('#transfer_request_value').val('');
      }
    });

    var balance = document.getElementById('balance-truckload');
    balance.innerHTML = `Usar valor disponível: R$ ${formatted_balance_value}`

    $('.value-transfer-request').removeClass('d-none');
    $('.label-transfer-checkboxes').removeClass('d-none');
    $('#driver-checkbox').removeClass('d-none');

    if (agent_bank_account.length){
      $('#agent-checkbox').removeClass('d-none');
    } else {
      $('#agent-checkbox').addClass('d-none');
    }

    $('#transfer_request_driver:checkbox').prop('checked', false);
    $('#transfer_request_agent:checkbox').prop('checked', false);
    $('#use_available:checkbox').prop('checked', false);
    $('#transfer_request_value').val('');
  })

  $('#driver-checkbox').click(function(){
    $('.bank-accounts').removeClass('d-none');
    $('#select-bank-accounts option').each(function(){
      this.remove();
      $('#transfer_request_agent:checkbox').prop('checked', false);
    });
    if (!$('#driver-bank-account').length){
      $.each(driver_bank_account, function(i, k){
        if (k['pix_key_type_cd'].length > 0) {
          $('#select-bank-accounts').append($('<option>', {
            id: `driver-bank-account-${k['id']}`,
            value: k['id'],
            text: `${k['bank_code']} - ${k['agency']} | ${k['account_number']} - ${k['account_name']} | Pix: ${I18n.t(`activerecord.attributes.bank_account.pix_types.${k['pix_key_type_cd']}`, { locale: 'pt-BR' })} - ${k['pix_key']}`
          }))
        } else {
          $('#select-bank-accounts').append($('<option>', {
            id: `driver-bank-account-${k['id']}`,
            value: k['id'],
            text: `${k['bank_code']} - ${k['agency']} | ${k['account_number']} - ${k['account_name']}`
          }))
        }
      });
    }
  });

  $('#agent-checkbox').click(function(){
    $('.bank-accounts').removeClass('d-none');
    $('#select-bank-accounts option').each(function(){
      this.remove();
      $('#transfer_request_driver:checkbox').prop('checked', false);
    });
    if (!$('#agent-bank-account').length){
      $.each(agent_bank_account, function(i, k){
        if (k['pix_key_type_cd'].length > 0) {
          $('#select-bank-accounts').append($('<option>', {
            id: `agent-bank-account-${k['id']}`,
            value: k['id'],
            text: `${k['bank_code']} - ${k['agency']} | ${k['account_number']} - ${k['account_name']} | Pix: ${I18n.t(`activerecord.attributes.bank_account.pix_types.${k['pix_key_type_cd']}`, { locale: 'pt-BR' })} - ${k['pix_key']}`
          }))
        } else {
          $('#select-bank-accounts').append($('<option>', {
            id: `agent-bank-account-${k['id']}`,
            value: k['id'],
            text: `${k['bank_code']} - ${k['agency']} | ${k['account_number']} - ${k['account_name']}`
          }))
        }
      });
    }
  });
});
