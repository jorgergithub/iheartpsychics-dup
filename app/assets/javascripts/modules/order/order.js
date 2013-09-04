Module("IHeartPsychics.Mediator", function(Mediator) {
  "use strict";

  Mediator.fn.initialize = function() {
    this.listeners = {};
  };

  Mediator.fn.on = function(event, callback) {
    this.listeners[event] || (this.listeners[event] = []);
    this.listeners[event].push(callback);
  };

  Mediator.fn.emit = function(event) {
    var args = Array.prototype.slice.apply(arguments, 1);
    this.listeners[event].forEach(function(callback) {
      callback(args);
    });
  };
});

Module("IHeartPsychics.OrderForm", function(Form) {
  "use strict";

  Form.fn.initialize = function(el) {
    // order form
    this.form = $(el).find("form");

    // events mediator
    this.mediator = IHeartPsychics.Mediator();

    // sub components
    this.package = IHeartPsychics.OrderForm.Package(this.form, this.mediator);
    this.payment = IHeartPsychics.OrderForm.Payment(this.form, this.mediator);

    // form buttons
    this.submit = this.form.find("button.go");
    this.cancel = this.form.find("a.cancel");

    // event wiring
    this.mediator.on("enable-buttons", function() {
      this.enableButtons();
    });
  };

  Form.fn.validate = function() {
    return this.package.validate() && this.payment.validate();
  };

  Form.fn.disableButtons = function() {
    this.submit.prop("disabled", true);
    this.cancel.hide();
  };

  Form.fn.enableButtons = function() {
    this.submit.prop("disabled", false);
    this.cancel.show();
  };

  Form.fn.process = function() {
    if (!this.validate()) {
      return false;
    }

    this.disableButtons();
    this.payment.process();
  }

  Form.fn.run = function() {
    this.form.submit(this.process.bind(this));
  }
});

Module("IHeartPsychics.OrderForm.Package", function(Package) {
  "use strict";

  Package.fn.initialize = function(el, mediator) {
    this.el = el.find(".package");
    this.error = this.el.find('#package-validation-error');
  };

  Package.fn.clearError = function() {
    this.error.text("");
  };

  Package.fn.displayError = function() {
    this.error.text("please select a package");
  };

  Package.fn.validate = function() {
    this.clearError();

    var selectedPackage = this.el.find("[name='order[package_id]']:checked");
    if (selectedPackage.length > 0) {
      return true;
    }

    this.displayError();
    return false;
  };
});

Module("IHeartPsychics.OrderForm.Payment", function(Payment) {
  "use strict";

  Payment.fn.initialize = function(el, mediator) {
    this.form = el;
    this.mediator = mediator;
    this.el = el.find(".payment");

    this.newCard = this.el.find("#order_card_id");
    this.cardNumber = this.el.find("#order_card_number");
    this.cardExpMonth = this.el.find("#order_card_month");
    this.cardExpYear = this.el.find("#order_card_year");
    this.cardCvc = this.el.find("#order_card_cvc");

    this.cardNumberValidationError = this.el.find("#card-number-validation-error");
    this.cardCvcValidationError = this.el.find("#card-cvc-validation-error");
    this.paymentError = this.el.find(".payment-errors");
  };

  Payment.fn.setNumberValidationError = function(error) {
    this.cardNumberValidationError.text(error);
    this.cardNumber.focus();
  };

  Payment.fn.setCvcValidationError = function(error) {
    this.cardCvcValidationError.text(error);
    this.cardCvc.focus();
  };

  Payment.fn.setPaymentError = function(error) {
    this.paymentError.text(error);
  };

  Payment.fn.clearErrors = function() {
    this.setNumberValidationError("");
    this.setCvcValidationError("");
    this.setPaymentError("");
  }

  Payment.fn.validate = function() {
    this.clearErrors();

    // if using an existing card, no validation is needed
    if (!this.newCard.is(":checked")) {
      return true;
    }

    // missing card number
    if (!this.cardNumber.val()) {
      this.setNumberValidationError("please enter credit card number");
      return false;
    }

    // invalid card number
    if (!Stripe.validateCardNumber(this.cardNumber.val())) {
      this.setNumberValidationError("invalid credit card number");
      return false;
    }

    // missing or short CVC number
    var cvcVal = this.cardCvc.val();
    if ((!cvcVal)||(cvcVal.length < 3)) {
      this.setCvcValidationError("please enter 3-digit CVC");
      return false;
    }

    return true;
  };

  Payment.fn.stripeResponseHandler = function(status, response) {
    if (response.error) {
      this.setPaymentError(response.error.message);
      this.mediator.emit("enable-buttons");
    }
    else {
      var tokenId = response.id;
      var token = $("<input type='hidden' name='order[stripe_token]'>").val(tokenId);
      this.form.append(token)
      this.form.submit();
    }
  };

  Payment.fn.process = function() {
    if (!this.newCard.is(":checked")) {
      return true;
    }

    Stripe.createToken(this.form, this.stripeResponseHandler.bind(this));
  }
});
