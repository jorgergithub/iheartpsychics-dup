$(document).ready(function() {
  if (!$('body.home').length) {
    return;
  }

  $('#faq-button').click(function(e) {
    e.preventDefault();
    e.stopPropagation();

    $(".overlay").fadeIn();
    $('#faq-modal').fadeIn();
  });

  $('#close-button').click(function(e) {
    e.preventDefault();
    e.stopPropagation();

    $("#faq-modal").fadeOut();
    $('.overlay').fadeOut();
  })
});
