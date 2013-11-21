$(document).ready(function() {
  $(".horoscopes nav.signs li").on("click", function(e) {
    var sign = $(this).data("sign");
    $(".horoscopes nav.signs li").removeClass("selected");
    $(this).addClass("selected");

    $(".horoscopes article.sign").removeClass("selected");
    $(".horoscopes article.sign[data-sign=" + sign + "]").addClass("selected");
  });

  $(".horoscopes nav.signs img.arrow.left").on("click", function(e) {
    $(this).siblings("ul.first").addClass("selected");
    $(this).siblings("ul.last").removeClass("selected");
  });

  $(".horoscopes nav.signs img.arrow.right").on("click", function(e) {
    $(this).siblings("ul.first").removeClass("selected");
    $(this).siblings("ul.last").addClass("selected");
  });
});