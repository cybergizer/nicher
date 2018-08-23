$(document).ready(function() {
  $(document).on('click','#new_niche', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createNicheDialog(fetchNicheFormContent, id);
  });

  $(document).on('click','.edit_niche_button', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    createNicheDialog(fetchUpdateNicheContent, id);
  });

  function createNicheDialog(fetchMethod, id){
    $(document.body).append('<div id="niche_form">No content</div>');
    $('#niche_form').dialog({
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

  $(document).on('click','form#save_niche #close', function(){
    $('#niche_form').dialog('destroy');
    $('#niche_form').remove();
  });

  $(document).on('click','form#save_niche button[type="submit"]', function(e) {
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
    }).success(function(data){
      nicheStatusCheck(data);
    });
    return false;
  });

  function nicheStatusCheck(data){
    if (data.status == 'ok') {
      $('#niche_form').dialog('destroy');
      $('#niche_form').remove();
      window.location = '/niches';
    } else {
      alertCreate('Niche cannot be a descendant of itself!');
    }
  }

  function validateNicheForm(form){
    var name_input = $(form).find('#niche_name');
    return name_input.val() != '';
  }

  function fetchNicheFormContent(id){
    $.ajax({
      url: '/niches/new',
      data: { id: id },
      success: function(data){
        $('#niche_form').html(data);
      }
    });
  }

  function fetchUpdateNicheContent(id){
    $.ajax({
      url: '/niches/' + id + '/edit',
      data: { id: id },
      success: function(data){
        $('#niche_form').html(data);
      }
    });
  }
});
