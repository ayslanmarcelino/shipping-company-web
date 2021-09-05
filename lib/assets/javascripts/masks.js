$(function(){
  const Masks = {
    decimalPlacesMoney: 2,
    decimalPlacesPercent: 1,
    fixMoneyInputValues($, selector, decimalPlaces) {
      $(selector).each((n, el) => {
        const value = el.value;
        if (value) $(el).val(parseFloat(value).toFixed(decimalPlaces));
      });
    },
  
    documentNumberMask: (val) => {
      const formattedValLength = val.replace(/\D/g, '').length;
      return formattedValLength > 11 || !formattedValLength ? '00.000.000/0000-00' : '000.000.000-009';
    },
    onKeyPress: f => ({ onKeyPress: (val, e, field, options) => field.mask(f(val), options) })
  }

  const m = Masks;
  m.fixMoneyInputValues($, '.input--money', m.decimalPlacesMoney);

  $('input[type=text].document_number').mask(m.documentNumberMask, m.onKeyPress(m.documentNumberMask));
  $('.input--cpf').mask('000.000.000-00', { reverse: true });
  $('.input--cnpj').mask('00.000.000/0000-00', { reverse: true });
  $('.input--zip-code').mask('00000-000');
  $('.input--money').mask('##0.00', { reverse: true, placeholder: '0.00' });
  $('.input--phone-number').mask('(00) 0000-0000');
  $('.input--telephone-number').mask('(00) 00000-0000');
  $('.input--bank-account').mask('##0-0', { reverse: true, placeholder: 'Ex: 1234-5' });
  $('.input--bank-agency').mask('##0', { reverse: true, placeholder: 'Ex: 1234' });
});
