$(function () {
  $('.dd').nestable();

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
      data: { id: currentItem, parent_id: itemParent }
    });
  }
})