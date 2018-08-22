$(document).ready(function () {
  $('.dd').nestable({
    afterInit: function(){
      $('.dd').find('.dd-item').map(function(_, el){ 
        if ($(el).find('.dd-list .dd-item').length == 0) {
          $(el).find('button[data-action="expand"]').hide();
          $(el).find('button[data-action="collapse"]').hide();
        } else {
          $(el).find('button[data-action="expand"]').show();
          $(el).find('button[data-action="collapse"]').hide();
        }
      });
    }
  });

  $('.dd').on('dragEnd', function(event, item, source, destination, position) {
    var currentItem = $(item).attr('data-id');
    var result = $(item).parent().parent().attr('data-id')
    var itemParent = (typeof result === "undefined" ? "": result);
    var typecheck = $(this).hasClass('niches');
    var priviousParent = $(item).attr('data-parent')
    if (priviousParent != itemParent){
      $(item).attr('data-parent', itemParent);
      if(typecheck) {
        moveElements('niches', currentItem, itemParent);
      }else{
        moveElements('categories', currentItem, itemParent);
      }
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