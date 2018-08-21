$(document).ready(function () {
  $('.dd').nestable({
    afterInit: function(){
      $('.dd').find('.dd-item').map(function(_, el){ 
        if ($(el).find('.dd-list .dd-item').length == 0) {
          $(el).children('button').hide();
        } else {
          $(el).find('button[data-action="expand"]').show();
          $(el).find('button[data-action="collapse"]').hide();
        }
      });
    }
  });

  $('.dd').on('dragEnd', function(event, item, source, destination, position) {
    var currentItem = $(item).attr('data-id');
    var itemParent = $(item).parent().parent().attr('data-id');
    var typecheck = $(this).hasClass('niches');
    if(typecheck) {
      moveElements('niches', currentItem, itemParent);
    }else{
      moveElements('categories', currentItem, itemParent);
    }
  });
  
  function moveElements(url, currentItem, itemParent){
    $.ajax({
      method: "POST",
      url: url + "/move",
      data: { id: currentItem, parent_id: itemParent },
      success: function(e){
        $("#notice").text("Successful move of element!").show();
      }
    });
  }
})