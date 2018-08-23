$(document).ready(function() {
  $(document).on('click','#new_category', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createCategoryDialog(fetchCategoryFormContent, id);
  });

  $(document).on('click','.edit_category_button', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createCategoryDialog(fetchUpdateCategoryContent, id);
  });

  function createCategoryDialog(fetchMethod, id){
    $(document.body).append('<div id="category_form">No content</div>');
    $('#category_form').dialog({
      modal: true,
      open: function(){
        fetchMethod(id);
      },
      close: function(){
        $(this).dialog('destroy');
        $(this).remove();     
      }
    });
    addStylesToDialog();
  }

  $(document).on('click','form#save_category #close', function(){
    $('#category_form').dialog('destroy');
    $('#category_form').remove();
  });

  $(document).on('click','form#save_category button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_category');
    var data = $(form).serialize();
    if (!validateCategoryForm(form)) {
      alertCreate('Please input name for category!');
      return;
    }
    $.ajax({
      type: "POST",
      url: $(form).attr('action'),
      data: data,
      dataType: "JSON"
    }).success(function(data){
      categoryStatusCheck(data);
    });
    return false;
  });

  function categoryStatusCheck(data){
    if (data.status == 'ok') {
      $('#category_form').dialog('destroy');
      $('#category_form').remove();
      window.location = '/categories';
    } else {
      alertCreate('Category cannot be a descendant of itself!');
    }
  }

  function validateCategoryForm(form){
    var name_input = $(form).find('#category_name');
    return name_input.val() != '';
  }

  function fetchCategoryFormContent(id){
    $.ajax({
      url: '/categories/new',
      data: { id: id },
      success: function(data){
        $('#category_form').html(data);
      }
    });
  }

  function fetchUpdateCategoryContent(id){
    $.ajax({
      url: '/categories/' + id + '/edit',
      data: { id: id },
      success: function(data){
        $('#category_form').html(data);
      }
    });
  }
});
