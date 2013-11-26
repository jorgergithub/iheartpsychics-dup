$(document).ready(function() {
  $(".modal_link").on("click", function(e) {
    e.preventDefault();
    var modalId = $(this).data("modal-id");

    if ($(".modal").is(":visible")) {
      $(".modal:visible").fadeOut(1000, function () {
        $("#" + modalId).fadeIn(1000);
      });
    } else {
      $("#" + modalId).fadeIn(1000);
      $(".overlay").fadeIn(1000);
    }
  });

  $(".modal .close-button, .overlay").on("click", function(e) {
    e.preventDefault();

    $(".modal").fadeOut(1000);
    $(".overlay").fadeOut(1000);
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
