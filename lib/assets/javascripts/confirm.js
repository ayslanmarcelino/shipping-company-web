import Rails from 'rails-ujs';

const confirmed = ($element, result) => {
  if (result.value) {
    const confirm = $element.data('confirm');
    const confirmPin = $element.data('confirm-pin');
    $element.removeAttr('data-confirm');
    $element.removeAttr('data-confirm-pin');
    $element[0].click();
    $element.attr('data-confirm', confirm);
    $element.attr('data-confirm-pin', confirmPin);
  }
};

const handleConfirmationResult = ($element, result) => {
  if (!result.value) return;
  confirmed($element, result);
};

const showConfirmationDialog = ($element) => {
  const message = $element.data('confirm');
  const text = $element.data('text');
  const confirmButton = $element.data('confirmButton');

  Swal.fire({
    title: message || 'Você tem certeza?',
    text: text || '',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: confirmButton || 'Sim',
    cancelButtonText: 'Cancelar',
  }).then(result => handleConfirmationResult($element, result));
};

const allowAction = (element) => {
  const $element = $(element);
  if ($element.data('confirm')) {
    showConfirmationDialog($element);
    return false;
  } if (requiresPinConfirmation($element)) {
    showPinDialog($element);
    return false;
  }

  return true;
};

function handleConfirm(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element);
  }
}

Rails.delegate(document,
               'a[data-confirm], input[data-confirm]',
               'click',
               handleConfirm);
Rails.delegate(document, 'submit', handleConfirm);
