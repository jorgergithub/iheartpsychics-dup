Module("IHP.Main.Modal.Payment", function(Payment) {
  "use strict";

  Payment.fn.initialize = function(el) {
    Emitter.extend(this);

    this.form = el;
    this.el = $(el);

    this.newCard = this.el.find("#order_card_id");
    this.cardNumber = this.el.find("#order_card_number");
    this.cardExpMonth = this.el.find("#order_card_exp_month");
    this.cardExpYear = this.el.find("#order_card_exp_year");
    this.cardCvc = this.el.find("#order_card_cvc");

    this.cardNumberValidationError = this.el.find("#card-number-validation-error");
    this.expirationDateValidationError = this.el.find("#card-exp-date-validation-error");
    this.cardCvcValidationError = this.el.find("#card-cvc-validation-error");
    this.paymentError = this.el.find(".payment-errors");

    this.el.off("submit").on("submit", this.validate.bind(this));
  };

  Payment.fn.setNumberValidationError = function(error) {
    this.cardNumberValidationError.text(error);
    // this.cardNumber.focus();
  };

  Payment.fn.setExpirateDateValidationError = function(error){
    this.expirationDateValidationError.text(error);
  }

  Payment.fn.setCvcValidationError = function(error) {
    this.cardCvcValidationError.text(error);
    // this.cardCvc.focus();
  };

  Payment.fn.setPaymentError = function(error) {
    this.paymentError.text(error);
  };

  Payment.fn.clearErrors = function() {
    this.setNumberValidationError("");
    this.setExpirateDateValidationError("");
    this.setCvcValidationError("");
    this.setPaymentError("");
  }

  Payment.fn.validate = function() {
    this.clearErrors();

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

    // invalid exp month
    if (!this.cardExpMonth.val()) {
      this.setExpirateDateValidationError("inform the expiration month");
      return false;
    }

    // invalid exp year
    if (!this.cardExpYear.val()) {
      this.setExpirateDateValidationError("inform the expiration year");
      return false;
    }

    // invalid exp date (lower than current date)
    if (!Stripe.validateExpiry(this.cardExpMonth.val(), this.cardExpYear.val())) {
      this.setExpirateDateValidationError("your credit card has a expired date");
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

      $(this.form).append(token);
      $(this.form).trigger('submit.rails');
    }
  };

  Payment.fn.charge = function() {
    this.emit("paymentStarted");
    console.log(this.el);
    Stripe.createToken(this.form, this.stripeResponseHandler.bind(this));
    return false;
  };
});
