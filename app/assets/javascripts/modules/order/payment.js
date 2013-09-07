Module("IHP.Pages.Orders.Payment", function(Payment) {
  "use strict";

  Payment.fn.initialize = function(el) {
    Emitter.extend(this);

    this.form = el;
    this.el = el.find(".payment");

    this.newCard = this.el.find("#order_card_id");
    this.cardNumber = this.el.find("#order_card_number");
    this.cardExpMonth = this.el.find("#order_card_month");
    this.cardExpYear = this.el.find("#order_card_year");
    this.cardCvc = this.el.find("#order_card_cvc");

    this.cardNumberValidationError = this.el.find("#card-number-validation-error");
    this.cardCvcValidationError = this.el.find("#card-cvc-validation-error");
    this.paymentError = this.form.find(".payment-errors");

    this.addEventListeners();
  };

  Payment.fn.addEventListeners = function() {
    // this.cardNumber.on("blur", this.validate.bind(this));
    // this.cardCvc.on("blur", this.validate.bind(this));
  }

  Payment.fn.setNumberValidationError = function(error) {
    this.cardNumberValidationError.text(error);
    // this.cardNumber.focus();
  };

  Payment.fn.setCvcValidationError = function(error) {
    this.cardCvcValidationError.text(error);
    // this.cardCvc.focus();
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

    return this.charge();
  };

  Payment.fn.stripeResponseHandler = function(status, response) {
    if (response.error) {
      this.emit("paymentError");

      this.setPaymentError(response.error.message);
    }
    else {
      this.emit("paymentSuccess");

      var tokenId = response.id;
      var token = $("<input type='hidden' name='order[stripe_token]'>").val(tokenId);

      this.form.append(token);
      this.form[0].submit();
    }
  };

  Payment.fn.charge = function() {
    this.emit("paymentStarted");
    Stripe.createToken(this.form, this.stripeResponseHandler.bind(this));
    return false;
  };
});
