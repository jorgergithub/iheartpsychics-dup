$(document).ready(function() {
  $('#tabs').bind('click', function (e) {
    var $target = $(e.target);
    var selector = $target.attr('href')
    var content = $(selector);

    $('.tab-pane').removeClass('active');

    $target.tab('show');
    return false;
  });

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
