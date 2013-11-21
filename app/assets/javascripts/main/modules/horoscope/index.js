$(document).ready(function() {
  $(".horoscopes nav.signs li").on("click", function(e) {
    var sign = $(this).data("sign");
    $(".horoscopes nav.signs li").removeClass("horoscope_selected");
    $(this).addClass("horoscope_selected");

    $(".horoscopes div.horoscopes_sign").removeClass("horoscope_selected");
    $(".horoscopes div.horoscopes_sign[data-sign=" + sign + "]").addClass("horoscope_selected");
  });

  $(".horoscopes nav.signs img.horoscope_arrow.horoscope_left").on("click", function(e) {
    $(this).siblings("ul.horoscope_first").addClass("horoscope_selected");
    $(this).siblings("ul.horoscope_last").removeClass("horoscope_selected");
  });

  $(".horoscopes nav.signs img.horoscope_arrow.horoscope_right").on("click", function(e) {
    $(this).siblings("ul.horoscope_first").removeClass("horoscope_selected");
    $(this).siblings("ul.horoscope_last").addClass("horoscope_selected");
  });
});