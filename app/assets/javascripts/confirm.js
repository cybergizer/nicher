$(document).ready(function() {
  $('.deleteitem').on('click', function() {
    $('.modal-body').text('Are you sure about deleting this item?');
    $('#deletelink').attr('href', '/items/'+$(this).data('id'));
  });

  $('.returnitem').on('click', function() {
    $('.modal-body').text('Are you sure it was returned?');
    $('#deletelink').attr('href', '/rent_items/repay?id='+$(this).data('id'));
  });

  $('.deleteniche').on('click', function() {
    $('.modal-body').text('Are you sure about deleting this niche?');
    $('#deletelink').attr('href', '/niches/'+$(this).data('id'));
  });

  $('.deletecategory').on('click', function() {
    $('.modal-body').text('Are you sure about deleting this category?');
    $('#deletelink').attr('href', '/categories/'+$(this).data('id'));
  });
});
