Module("IHP.Modals.SignInErrorModal", function(Modal) {
  "use strict";

  Modal.fn.initialize = function(options) {
    this.el = $("#sign_in_error_modal", "body");
    this.form = $("form", this.el);
    this.showErrors = false;

    if (options) {
      this.showErrors = options.withErrors;
      this.message = options.message;
    }

    this.assign();
    this.addEventListeners();
  };

  Modal.fn.assign = function() {
    if (this.showErrors) {
      this.handleErrorMessage();
    } else {
      this.hideErrorMessage();
      this.resetForm();
    }
  };

  Modal.fn.addEventListeners = function() {
    this.el.off("ajax:success", "form").on("ajax:success", "form", this.onSuccess.bind(this));
    this.el.off("ajax:error", "form").on("ajax:error", "form", this.onError.bind(this));
  };

  Modal.fn.onSuccess = function(e, data, status, xhr) {
    this.hideErrorMessage();
  };

  Modal.fn.onError = function(e, data, status, xhr) {
    this.message = data.responseText;
    this.handleErrorMessage();
  };

  Modal.fn.handleErrorMessage = function() {
    var errors = $(".form_validation_errors", this.el),
        fields = $(".row", this.el),
        submit = $("input[type=image]", this.el),
        signinLinks = $(".footer_links", this.el);

    errors.html("<ul><li>" + this.message + "</li></ul>");
    errors.show();

    if (this.message != "Invalid login or password.") {
      fields.hide();
      submit.hide();
      signinLinks.hide();
    } else {
      fields.show();
      submit.show();
      signinLinks.show();
    }
  };

  Modal.fn.hideErrorMessage = function() {
    $(".form_validation_errors", this.el).hide();
  };

  Modal.fn.resetForm = function() {
    $("form", this.el)[0].reset();
  };
});
