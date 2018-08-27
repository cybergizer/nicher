function alertCreate(alertMessage, selector, statusAlert, delay) {
  $(selector).addClass('alert alert-' + statusAlert).html(alertMessage).fadeIn().fadeOut(delay);
}
