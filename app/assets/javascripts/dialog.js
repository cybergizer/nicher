function addStylesToDialog() {
  var $dialog = $(".ui-dialog");
  $dialog.addClass("modal-content");
  $dialog.find(".ui-dialog-titlebar").find(".ui-dialog-titlebar-close").hide();
  $dialog.find(".ui-dialog-content").addClass("sweet-alert");
  $dialog.children('.ui-resizable-handle').hide();
}
