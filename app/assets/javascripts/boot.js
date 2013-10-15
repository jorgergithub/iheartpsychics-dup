$(document).ready(function() {
  var body = $("body");
  var page = body.data("page");

  if (page) {
    Module.run("IHP.Pages." + page, body);
  }

  $('.nav-tabs a').on('shown', function (e) {
    if (history.pushState) {
      history.pushState(null, null, e.target.hash);
    } else {
      window.location.hash = e.target.hash;
    }
  })

  if (location.hash) {
    $('a[href=' + location.hash + ']').tab('show');
  }
});

$(window).on('popstate', function() {
  var anchor = location.hash || $("a[data-toggle=tab]").first().attr("href");
  $('a[href=' + anchor + ']').tab('show');
});
