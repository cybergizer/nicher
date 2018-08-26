function alertCreate(alertMessage) {
  $('#error_explanation').addClass('alert alert-warning').html(alertMessage).fadeIn().fadeOut(10000);
}
