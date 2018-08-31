$(document).ready(function() {
  if ($(".main_welcome").length){
    $(".main_welcome").onepage_scroll({
      sectionContainer: ".page",
      easing: "ease",
      animationTime: 1000,
      pagination: true,
      updateURL: false,
      beforeMove: function(index) {},
      afterMove: function(index) {},
      loop: false,
      keyboard: true,
      responsiveFallback: false,
      direction: "vertical"  
    });
  } else {
    $('body').css({ 'overflow': 'auto' });
  }
});
