$(document).ready(function() {
  $(document).on('click', '.lend_item', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    $(document.body).append('<div id="rent_form"></div>');
    $('#rent_form').dialog({
      title: 'Rent your Item',
      modal: true,
      open: function() {
        addStylesToDialog();
        fetchRentFormContent(id);
      },
      close: closeRentItemDialog
    });
  });

  $(document).on('click', 'form#save_rent_item #close', closeRentItemDialog);

  $(document).on('submit','form#save_rent_item', function(e) {
    e.preventDefault();
  });

  $(document).on('click', 'form#save_rent_item button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_rent_item');
    var data = $(form).serialize();
    if (!validateRentForm(form)) {
      alertCreate('Please input name for contact!');
      return;
    }
    $.ajax({
      type: "POST",
      url: $(form).attr('action'),
      data: data,
      dataType: "JSON"
    }).success(function(data) {
      if (data.status == 'ok') {
        closeRentItemDialog();
        window.location = '/items';
      }
    });
    return false;
  });

  function validateRentForm(form) {
    var name_input = $(form).find('#rent_item_tenant_attributes_name');
    return name_input.val() != '';
  }

  function closeRentItemDialog() {
    $('#rent_form').dialog('destroy');
    $('#rent_form').remove();
  }

  function fetchRentFormContent(id) {
    $.ajax({
      url: '/rent_items/rent_form',
      data: { id: id },
      success: function(data) {
        $('#rent_form').html(data);
      }
    });
  }
});
