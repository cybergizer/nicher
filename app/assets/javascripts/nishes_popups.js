$(document).ready(function() {
  $(document).on('click', '#new_niche', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createNicheDialog(id, 'new');
  });

  $(document).on('click', '.edit_niche_button', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    url = id + '/edit';
    createNicheDialog(id, url);
  });

  function createNicheDialog(id, url){
    $(document.body).append('<div id="niche_form"></div>');
    $('#niche_form').dialog({
      title: 'Niche',
      modal: true,
      open: function() {
        addStylesToDialog();
        fetchNicheFormContent(id, url);
      },
      close: closeNicheDialog
    });
  }

  $(document).on('submit', 'form#save_niche', function(e) {
    e.preventDefault();
  });

  $(document).on('click', 'form#save_niche #close', closeNicheDialog);

  $(document).on('click', 'form#save_niche button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_niche');
    var data = $(form).serialize();
    var errors = validateNicheForm(form);
    if (!$.isEmptyObject(errors)) {
      var alert_text = createAlertText(errors);
      alertCreate(alert_text, '#error_explanation', 'warning', 10000);
      return;
    }
    $.ajax({
      type: "POST",
      url: $(form).attr('action'),
      data: data,
      dataType: "JSON"
    }).success(function(data) {
      nicheStatusCheck(data);
    });
    return false;
  });

  function closeNicheDialog() {
    $('#niche_form').dialog('destroy');
    $('#niche_form').remove();
  }

  function nicheStatusCheck(data) {
    if (data.status == 'ok') {
      closeNicheDialog();
      window.location = '/niches';
    } else {
      alertCreate(data.status, '#error_explanation', 'warning', 10000);
    }
  }

  function validateNicheForm(form) {
    var errors = [];
    validateNicheName(form, errors);
    validateNicheUrl(form, errors);
    return errors;
  }

  function validateNicheName(form, errors) {
    var name_input = $(form).find('#niche_name');
    if (name_input.val() == '') {
      errors.push('Please input name for niche!');
    }
    return errors;
  }

  function validateNicheUrl(form, errors) {
    var url_pattern = /[A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&;\?\#\/.=]+/;
    var url_text = $(form).find('#niche_url').val();
    if (!($.isEmptyObject(url_text) || url_pattern.test(url_text))) {
      errors.push('Invalid url for niche!');
    }
    return errors;
  }

  function createAlertText(errors) {
    return errors.join('<br>');
  }

  function fetchNicheFormContent(id, url) {
    $.ajax({
      url: '/niches/' + url,
      data: { id: id },
      success: function(data) {
        $('#niche_form').html(data);
      }
    });
  }
});
