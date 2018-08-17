$(document).ready(function() {
    $(document).on('click','.lend_item', function(e) {
      e.preventDefault();
      var id = $(this).data('id');
      $(document.body).append('<div id="rent_form">No content</div>');
      $('#rent_form').dialog({
          modal: true,
          open: function(){
            fetchRentFormContent(id);
          },
          close: function(){
            $(this).dialog('destroy');
            $(this).remove();     
          }
      });
      var $dialog = $(".ui-dialog");
      $dialog.addClass("modal-content");
      $dialog.find(".ui-dialog-titlebar").find(".ui-dialog-titlebar-close").hide();
      $dialog.find(".ui-dialog-content").addClass("sweet-alert");
      $dialog.children('.ui-resizable-handle').hide();
    });

    $(document).on('click','form#save_rent_item #close', function(){
      $('#rent_form').dialog('destroy');
      $('#rent_form').remove();
    });

    $(document).on('click','form#save_rent_item button[type="submit"]', function(e) {
      e.preventDefault();
      var form = $(this).parents('form#save_rent_item');
      var data = $(form).serialize();
      if (!validateRentForm(form)) {
        $('#error_explanation').addClass('alert alert-warning').html('Please input name for contact!').fadeIn().fadeOut(10000);
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
