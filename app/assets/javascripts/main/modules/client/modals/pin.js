Module("IHP.Modals.PinModal", function(PinModal) {
  "use strict";

  PinModal.fn.initialize = function(el) {
    this.el = $("#pin_modal", el);
    this.pin = $("#client_pin", el);
    this.assign();
    this.onDismiss();
  };

  PinModal.fn.assign = function() {
    this.pin.val(this.el.attr("data-pin"));
    this.pin.select();
    this.pin.focus();
  };

  PinModal.fn.onDismiss = function() {
    this.el.off("dismiss").on("dismiss", function() {
      $("#pin_modal").find(".form_validation_errors").remove();
    });
  };
});
