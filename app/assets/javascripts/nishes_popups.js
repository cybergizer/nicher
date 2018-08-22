$(document).ready(function() {
  $(document).on('click','#new_niche', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    $(document.body).append('<div id="niche_form">No content</div>');
    $('#niche_form').dialog({
        modal: true,
        open: function(){
          fetchNicheFormContent(id);
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

  $(document).on('click','.edit_niche_button', function(e) {
    e.preventDefault();
    var id = $(this).data('id');
    $(document.body).append('<div id="niche_form">No content</div>');
    $('#niche_form').dialog({
        modal: true,
        open: function(){
          fetchUpdateNicheContent(id);
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

  $(document).on('click','form#save_niche #close', function(){
    $('#niche_form').dialog('destroy');
    $('#niche_form').remove();
  });

  $(document).on('click','form#save_niche button[type="submit"]', function(e) {
    e.preventDefault();
    var form = $(this).parents('form#save_niche');
    var data = $(form).serialize();
    if (!validateNicheForm(form)) {
      $('#error_explanation').addClass('alert alert-warning').html('Please input name for niche!').fadeIn().fadeOut(10000);
      return;
    }
    $.ajax({
      type: "POST",
      url: $(form).attr('action'),
      data: data,
      dataType: "JSON"
    }).success(function(data){
      if (data.status == 'ok') {
        $('#niche_form').dialog('destroy');
        $('#niche_form').remove();
        window.location = '/niches';
      }
    });
    return false;
  });

  function validateNicheForm(form){
    var name_input = $(form).find('#niche_name');
    return name_input.val() != '';
  }

  function fetchNicheFormContent(id){
    $.ajax({
      url: '/niches/new',
      data: { id: id},
      success: function(data){
        $('#niche_form').html(data);
      }
    });
  }

  function fetchUpdateNicheContent(id){
    $.ajax({
      url: '/niches/' + id + '/edit',
      data: { id: id},
      success: function(data){
        $('#niche_form').html(data);
      }
    });
  }
});