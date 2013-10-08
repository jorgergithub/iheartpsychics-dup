$(document).ready(function() {
  var body = $("body");
  var page = body.data("page");

  if (page) {
    Module.run("IHP.Pages." + page, body);
  }

  $('[data-mask]').each(function(index) {
    var $this = $(this);
    $this.mask($this.data('mask').toString());
  });
});
