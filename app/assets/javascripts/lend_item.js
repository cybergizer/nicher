$(document).ready(function() {
  $('.lend_item').click(function(e) {
      e.preventDefault();
      var id = $(this).attr('data-id');
      $(document.body).append('<div id="rent_form">Fake </div>');
      $('#rent_form').dialog({
          open: function(){
            fetchRentFormContent(id);
          }
      });
      var $dialog = $(".ui-dialog");
      $dialog.addClass("modal-content");
      $dialog.find(".ui-dialog-titlebar").addClass("modal-header").find(".ui-button").addClass("close").text("x");
      $dialog.find(".ui-dialog-content").addClass("modal-body");
  });
  $('#save_rent_item').submit(function() {  
    var valuesToSubmit = $(this).serialize();
    $.ajax({
        type: "POST",
        url: $(this).attr('action'),
        data: valuesToSubmit,
        dataType: "JSON" 
    }).success(function(json){
        console.log("success", json);
    });
    return false;
});

  function fetchRentFormContent(id){
    $.ajax({
        url: '/items/rent_form',
        data: { id: id},
        success: function(data){
            $('#rent_form').html(data);
        }
    });
  }
});
