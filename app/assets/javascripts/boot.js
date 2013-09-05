$(document).ready(function() {
  var page = $("body").data("page");
  if (page) {
    Module.run("IHP.Pages." + page);
  }
});
