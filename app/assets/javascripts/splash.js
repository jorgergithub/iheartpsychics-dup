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

  $('.close-button').on('click', function(e) {
    e.preventDefault();
    e.stopPropagation();

    $("#confirmation-modal").fadeOut();
    $("#faq-modal").fadeOut();
    $('.overlay').fadeOut();
  });

  $("#subscribe").click(function(e) {
    e.preventDefault();
    e.stopPropagation();

    $("form").submit();
  });

  $(".countdown-link").click(function() {
    $(".countdown").show();
    $(".splash-video").hide();
    $(this).siblings().removeClass("splash-selected");
    $(this).addClass("splash-selected");
  });

  $(".video-link").click(function() {
    $(".countdown").hide();
    $(".splash-video").show();
    $(this).siblings().removeClass("splash-selected");
    $(this).addClass("splash-selected");
  });
});
