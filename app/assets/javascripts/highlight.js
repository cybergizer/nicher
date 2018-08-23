$(document).ready(function() {
  $(document).on('click','.highlight', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    $.ajax({
      url: '/niches/highlight',
      data: { id: id },
      success: function(data) {
        if (data.status == 'ok') {
          alertCreate("Highlighted!", '#notice', 'success', 5000);
        }
      }
    });
  });
});
