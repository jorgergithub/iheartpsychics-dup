var MODAL_FADE = 400;

$(document).ready(function() {

  var executeModalComponent = function(modalId) {
    var parts = modalId.split("_");
    var newModalId = "";
    for (var i = 0; i < parts.length; i++) {
      var string = parts[i];
      newModalId += string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }

    console.log("executeModalComponent", newModalId);
    Module.run("IHP.Modals." + newModalId);
  };

  $("body").on("click", ".modal_link", function(e) {
    e.preventDefault();
    var modalId = $(this).data("modal-id");

    if ($(".modal").is(":visible")) {
      $(".modal:visible").fadeOut(MODAL_FADE, function () {
        $("#" + modalId).fadeIn(MODAL_FADE);
      });
    } else {
      $("#" + modalId).fadeIn(MODAL_FADE);
      $(".overlay").fadeIn(MODAL_FADE);
      executeModalComponent(modalId);
    }
  });

  $(".modal").on("click", ".close-button", function(e) {
    e.preventDefault();

    closeModal();
    dismissModal();
  });


  $("body").on("click", ".overlay", function(e) {
    e.preventDefault();

    closeModal();
    dismissModal();
  });

  $(".modal").on("click", ".reset_form", function(e) {
    e.preventDefault();

    $(this).closest("form")[0].reset();
  });

  $("a[data-close-modal]").on("click",  function(e) {
    e.preventDefault();
    var selector = $(this).attr("data-close-modal");
    var el = $(selector);

    el.fadeOut();
    dismissModal();
  });
});

window.closeModal = function() {
  $(".modal").fadeOut(MODAL_FADE);
  $(".overlay").fadeOut(MODAL_FADE);
}

window.dismissModal = function() {
  $(".modal:visible").trigger("dismiss");
}