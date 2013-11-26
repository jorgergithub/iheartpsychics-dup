Module("IHP.Components.CallbackModal", function(CallbackModal) {
  "use strict";

  CallbackModal.fn.initialize = function(el, psychicId) {
    console.log("CallbackModal", psychicId);
    console.log("CallbackModal", el);
    this.el = $(el.find("#callback-modal"));
    this.overlay = $(el.find(".overlay"));
    this.addEventListeners();
  };

  CallbackModal.fn.addEventListeners = function() {
    this.el.on("click", ".callback-modal-cancel", this.whenCancelIsClicked.bind(this));
  };

  CallbackModal.fn.show = function() {
    this.el.fadeIn();
    this.overlay.fadeIn();
  };

  CallbackModal.fn.hide = function() {
    this.el.fadeOut();
    this.overlay.fadeOut();
  };

  CallbackModal.fn.whenCancelIsClicked = function(e) {
    e.preventDefault();
    this.hide();
  };
});

Module("IHP.Components.Callbacks", function(Callbacks) {
  "use strict";

  Callbacks.fn.initialize = function(el, psychicId) {
    console.log("Callbacks", psychicId);

    this.el = el;
    this.psychicId = psychicId;
    this.modal = IHP.Components.CallbackModal(this.el);
    this.modal.show();
  };
});
