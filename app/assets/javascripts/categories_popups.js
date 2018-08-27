$(document).ready(function() {
  $(document).on('click', '#new_category', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createCategoryDialog(id, 'new');
  });

  $(document).on('click', '.edit_category_button', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    url = id + '/edit';
    createCategoryDialog(id, url);
  });

  function createCategoryDialog(id, url) {
    $(document.body).append('<div id="category_form"></div>');
    $('#category_form').dialog({
      title: 'Category',
      modal: true,
      open: function(){
        addStylesToDialog();
        fetchCategoryFormContent(id, url);
      },
      close: closeCategoryDialog
    });
  }

  $(document).on('submit', 'form#save_category', function(e) {
    e.preventDefault();
  });

  $(document).on('click', 'form#save_category #close', closeCategoryDialog);

  function closeCategoryDialog() {
    $('#category_form').dialog('destroy');
    $('#category_form').remove();
  }

  $(document).on('click', 'form#save_category button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_category');
    var data = $(form).serialize();
    if (!validateCategoryForm(form)) {
      alertCreate('Please input name for category!', '#error_explanation', 'warning', 10000);
      return;
    }
    $.ajax({
      type: "POST",
      url: $(form).attr('action'),
      data: data,
      dataType: "JSON"
    }).success(function(data) {
      categoryStatusCheck(data);
    });
    return false;
  });

  function categoryStatusCheck(data) {
    if (data.status == 'ok') {
      closeCategoryDialog();
      window.location = '/categories';
    } else {
      alertCreate('Category cannot be a descendant of itself!', '#error_explanation', 'warning', 10000);
    }
  }

  function validateCategoryForm(form) {
    var name_input = $(form).find('#category_name');
    return name_input.val() != '';
  }

  function fetchCategoryFormContent(id, url) {
    $.ajax({
      url: '/categories/' + url,
      data: { id: id },
      success: function(data) {
        $('#category_form').html(data);
      }
    });
  }
});
