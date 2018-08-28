$(document).ready(function() {
  var num = Math.floor(Math.random() * 7);
  if (num == 5) {
    num = num - 1;
  }
  $('#'+num).html('&nbsp'+'&nbsp');
});
