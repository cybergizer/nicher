$(document).ready(function() {
  $("#timeline").css({ 'display': 'none' });
  $("#history").on('click', function() {
    $("#timeline").toggle();
  });
});
