$(document).ready(function() {
  $(".modal_link").on("click", function(e) {
    e.preventDefault();
    var modalId = $(this).data("modal-id");
    
    $("#" + modalId).fadeIn();
    $(".overlay").fadeIn();
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