$(document).ready(function() {
  $('.birthday_picker').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#pre-load').attr('src', e.target.result);
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#imgInp").change(function() {
      readURL(this);
  });
});
