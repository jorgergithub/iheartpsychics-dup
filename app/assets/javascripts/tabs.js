$(document).ready(function() {
  $('#tabs').bind('click', function (e) {
    var $target = $(e.target);
    var selector = $target.attr('href')
    var content = $(selector);

    $('.tab-pane').removeClass('active');

    $target.tab('show');
    return false;
  });
});
