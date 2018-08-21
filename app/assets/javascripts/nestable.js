$(function () {
  $('.dd').nestable();

  $('.dd').on('change', function () {
      var $this = $(this);
      var data = window.JSON.stringify($($this).nestable('serialize'));
      alert(data)
      $.ajax({
        type: "POST",
        url: 'niches/move',
        data: {tree: data},
        dataType: "JSON"
      });
  });
});