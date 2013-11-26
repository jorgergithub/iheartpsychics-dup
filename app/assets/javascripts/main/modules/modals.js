$(document).ready(function() {
  $(".modal_link").on("click", function(e) {
    e.preventDefault();
    var modalId = $(this).data("modal-id");
    
    if ($(".modal").is(":visible")) {
      $(".modal").fadeOut(2000, function () {
        $("#" + modalId).fadeIn(2000);
      });
    } else {
      $("#" + modalId).fadeIn();
      $(".overlay").fadeIn();     
    }
  });

  $(".modal .close-button, .overlay").on("click", function(e) {
    e.preventDefault();

    $(".modal").fadeOut();
    $(".overlay").fadeOut();
  });

  $(".modal .reset_form").on("click", function(e) {
    e.preventDefault();

    $(this).closest("form")[0].reset();
  });
});