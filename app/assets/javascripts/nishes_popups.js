$(document).ready(function() {
  $(document).on('click', '#new_niche', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createNicheDialog(id, 'new');
  });

  $(document).on('click','.edit_niche_button', function(e) {
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
      open: function(){
        addStylesToDialog();
        fetchNicheFormContent(id, url);
      },
      close: closeNicheDialog
    });
  }

  $(document).on('submit','form#save_niche', function(e) {
    e.preventDefault();
  });

  $(document).on('click', 'form#save_niche #close', closeNicheDialog);

  $(document).on('click', 'form#save_niche button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_niche');
    var data = $(form).serialize();
    if (!validateNicheForm(form)) {
      alertCreate('Please input name for niche!');
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
      alertCreate('Niche cannot be a descendant of itself!');
    }
  }

  function validateNicheForm(form) {
    var name_input = $(form).find('#niche_name');
    return name_input.val() != '';
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
