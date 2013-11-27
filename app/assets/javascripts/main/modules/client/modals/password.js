Module("IHP.Modals.PasswordModal", function(PasswordModal) {
  "use strict";

  PasswordModal.fn.initialize = function(el) {
    this.el = $("#password_modal", el);
    this.new_password = $("#user_password", el);
    this.assign();
    this.onDismiss();
  };

  PasswordModal.fn.assign = function() {
    this.new_password.focus();
  };

  PasswordModal.fn.onDismiss = function() {
    this.el.off("dismiss").on("dismiss", function() {
      $("#password_modal").find(".form_validation_errors").remove();
      $("#password_modal").find("form")[0].reset();
    });
  };
});
