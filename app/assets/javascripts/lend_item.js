$(document).ready(function() {
    $(document).on('click','.lend_item', function(e) {
      e.preventDefault();
      var id = $(this).attr('data-id');
      $(document.body).append('<div id="rent_form">No content</div>');
      $('#rent_form').dialog({
          open: function(){
            fetchRentFormContent(id);
          },
      });
      var $dialog = $(".ui-dialog");
      $dialog.addClass("modal-content");
      $dialog.addClass("sweet-alert show-input showSweetAlert visible");
      $dialog.find(".ui-dialog-titlebar").addClass("modal-header").find(".ui-dialog-titlebar-close").addClass("close").text("x");
      $dialog.find(".ui-dialog-content").addClass("modal-body");
  });
  
  $(document).on('click','form#save_rent_item input[type="submit"]', function(e) {
    e.preventDefault();
    var button = this;
    var form = $(this).parents('form#save_rent_item');
    var data = $(form).serialize();
    if (!validateRentForm(form)) {
        $('#error_explanation').html('Please input name for contact!');
        return;
    }
    $.ajax({
        type: "POST",
        url: $(form).attr('action'),
        data: data,
        dataType: "JSON"
    }).success(function(data){
        if (data.status == 'ok') {
            $('#rent_form').dialog('destroy');
            $('#rent_form').remove();
            window.location = '/items';
        } 
    });
    return false;
});

function validateRentForm(form){
    var name_input = $(form).find('#rent_item_tenant_attributes_name');
    return name_input.val() != '';
}
  function fetchRentFormContent(id){
    $.ajax({
        url: '/rent_form',
        data: { id: id},
        success: function(data){
            $('#rent_form').html(data);
        }
    });
  }
});
