$(document).ready(function() {
  $(document).on('click','.share_item', function(e) {
    e.preventDefault();
    var id = $(this).attr('data-id');
    $(document.body).append('<div id="share_form"></div>');
    $('#share_form').dialog({
      open: function() {
        addStylesToDialog();
        fetchShareFormContent(id);
      },
      close: closeShareItemDialog
    });
  });

  $(document).on('click','#close', closeShareItemDialog);

  function closeShareItemDialog() {
    $('#share_form').dialog('destroy');
    $('#share_form').remove();
  }

  function fetchShareFormContent(id) {
    $.ajax({
      url: '/generate_link',
      data: { id: id},
      success: function(data){
        $('#share_form').html(data);
      }
    });
  }

  $(document).on('click','#copy', copyText);

  function copyText() {
    var textLink = $('#generatedLink');
    textLink.select();
    document.execCommand("copy");
    $('#share_form').dialog('destroy');
    $('#share_form').remove();
  }
});
