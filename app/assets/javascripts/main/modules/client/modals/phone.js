Module("IHP.Modals.PhoneModal", function(PhoneModal) {
  "use strict";

  PhoneModal.fn.initialize = function(el) {
    this.el = $("#phone_modal", el);
    this.number = $("#client_phone_number", el);
    this.assign();
    this.bindDismiss();
  };

  PhoneModal.fn.assign = function() {
    var phone = $("p#client_phone").text();
    $("#phone_modal").find("input#client_phone_number").val(phone);
    
    this.number.select();
    this.number.focus();
  };

  PhoneModal.fn.bindDismiss = function() {
    this.el.on("dismiss", function() {
      $("#phone_modal").find("div.form_validation_errors").remove();
    });
  };
});
