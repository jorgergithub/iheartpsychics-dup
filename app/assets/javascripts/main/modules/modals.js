var MODAL_FADE = 400;

$(document).ready(function() {
  $(".modal_link").on("click", function(e) {
    e.preventDefault();
    var modalId = $(this).data("modal-id");

    if ($(".modal").is(":visible")) {
      $(".modal:visible").fadeOut(MODAL_FADE, function () {
        $("#" + modalId).fadeIn(MODAL_FADE);
      });
    } else {
      $("#" + modalId).fadeIn(MODAL_FADE);
      $(".overlay").fadeIn(MODAL_FADE);
    }
  });

  $(".modal .close-button, .overlay").on("click", function(e) {
    e.preventDefault();

    $(".modal").fadeOut(MODAL_FADE);
    $(".overlay").fadeOut(MODAL_FADE);
  });

  $(".modal .reset_form").on("click", function(e) {
    e.preventDefault();

    $(this).closest("form")[0].reset();
  });

  $("a[data-close-modal]").on("click", function(e) {
    e.preventDefault();
    var selector = $(this).attr("data-close-modal");
    var el = $(selector);

    el.fadeOut();
    $(".overlay").fadeOut();
  });
});
