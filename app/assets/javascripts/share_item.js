$(document).ready(function() {
  $(document).on('click','.share_item', function(e) {
    e.preventDefault();
    var id = $(this).attr('data-id');
    $(document.body).append('<div id="share_form"></div>');
    $('#share_form').dialog({
      open: function(){
        fetchShareFormContent(id);
      }
    });
    var $dialog = $(".ui-dialog");
    $dialog.addClass("modal-content");
    $dialog.find(".ui-dialog-titlebar").find(".ui-dialog-titlebar-close").hide();
    $dialog.find(".ui-dialog-content").addClass("sweet-alert");
    $dialog.children('.ui-resizable-handle').hide();

  });

  $(document).on('click','#close', function(){
    $('#share_form').dialog('destroy');
    $('#share_form').remove();
  });

  function fetchShareFormContent(id){
    $.ajax({
      url: '/generate_link',
      data: { id: id},
      success: function(data){
        $('#share_form').html(data);
      }
    });
  }


  $(document).on('click','#copyButton', myFunction);

  function myFunction() {
    var copyText = $('#generatedLink');
    copyText.select();
    document.execCommand("copy");
    $('#share_form').dialog('destroy');
    $('#share_form').remove();
  }
});
