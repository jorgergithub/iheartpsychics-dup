Module("IHP.Main.Modal.Modal", function(Modal) {
  "use strict";

  Modal.fn.MODAL_FADE = 400

  Modal.fn.initialize = function(modalId, modalAttributes) {
    this.modalId = modalId;
    this.el = $("#" + modalId);

    this.assign();
    Module.run("IHP.Modals." + this.camelizedModalId(), [modalAttributes]);
    this.addEventListeners();
  };

  Modal.fn.assign = function() {
    $(".spinner_overlay", this.el).hide();
    var modal = this.el;
    if ($(".modal").is(":visible")) {
      $(".modal:visible").fadeOut(Modal.MODAL_FADE, function () {
        modal.fadeIn(Modal.MODAL_FADE);
      });
    } else {
      this.el.fadeIn(Modal.MODAL_FADE);
      $(".overlay").fadeIn(Modal.MODAL_FADE);
    }
  };

  Modal.fn.camelizedModalId = function() {
    var parts = this.modalId.split("_");
    var camelized = "";
    for (var i = 0; i < parts.length; i++) {
      var string = parts[i];
      camelized += string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }
    return camelized;
  };

  Modal.fn.addEventListeners = function() {
    this.bindCloseModal();
    $("body").off("click", ".overlay").on("click", ".overlay", closeModal);
    this.el.off("click", ".close-button").on("click", ".close-button", closeModal);
    this.el.off("submit", "form").on("submit", "form", this.onFormSubmit);
  };

  Modal.fn.bindCloseModal = function() {
    window.closeModal = function(e) {
      e.preventDefault();
      $(".modal").fadeOut(Modal.MODAL_FADE);
      $(".overlay").fadeOut(Modal.MODAL_FADE);
    }
  };

  Modal.fn.onFormSubmit = function(e) {
    var $form = $(e.target);
    var $submitButtons = $("input[type='image']", $form);
    var $spinner = $(".spinner_overlay");

    $submitButtons.prop("disabled", true);
    var originalSrc = $submitButtons.attr("src");
    var newSrc = originalSrc.replace(".png","_disabled.png")
    $submitButtons.attr("src", newSrc);

    $spinner.fadeIn();
  
    $form.on('ajax:complete', function(xhr, status) {
      $submitButtons.prop("disabled", false);
      var originalSrc = $submitButtons.attr("src");
      var newSrc = originalSrc.replace("_disabled.png",".png")
      $submitButtons.attr("src", newSrc);

      $spinner.fadeOut();
    });
  };
});
