$(function(){
  const Masks = {
    documentNumberMask: (val) => {
      const formattedValLength = val.replace(/\D/g, '').length;
      return formattedValLength > 11 || !formattedValLength ? '00.000.000/0000-00' : '000.000.000-009';
    },
    onKeyPress: f => ({ onKeyPress: (val, e, field, options) => field.mask(f(val), options) })
  }

  const m = Masks;

  $('input[type=text].document_number').mask(m.documentNumberMask, m.onKeyPress(m.documentNumberMask));
  $('.input--cpf').mask('000.000.000-00', { reverse: true });
  $('.input--cnpj').mask('00.000.000/0000-00', { reverse: true });
  $('.input--zip-code').mask('00000-000');
  $('.input--money').mask('##0.00', { reverse: true, placeholder: '0.00' });
});
