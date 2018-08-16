$(document).ready(function() {
    $(document).on('click','.share_item', function(e) {
      e.preventDefault();
      var id = $(this).attr('data-id');
      $(document.body).append('<div id="share_form"></div>');
      $('#share_form').dialog({
        width: 300,
        height: 100,
        title: "Generated Link",
        open: function(){
          fetchShareFormContent(id);
        }
      });
      var $dialog = $(".ui-dialog");
      $dialog.addClass("modal-content");
      $dialog.find(".ui-dialog-titlebar").addClass("modal-header").find(".ui-dialog-titlebar-close").addClass("close").text("x");
      $dialog.find(".ui-dialog-content").addClass("modal-body");
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
    var copyText = $('#generatedLink')
    copyText.select();
    document.execCommand("copy");
    alert("Copied!");
  }
});
