describe("IHP.Pages.Orders.Payment", function() {
  var form, container, payment;
  var newCard, cardNumber, cardExpMonth, cardExpMonth, cardCvc;
  var cardNumberValidationError, cardCvcValidationError, paymentError;

  beforeEach(function() {
    form = $("<form/>").appendTo(".output");
    container = $("<div class='payment'/>").appendTo(form);

    newCard = $("<input type='radio' id='order_card_id'/>").appendTo(container);
    cardNumber = $("<input id='order_card_number'/>").appendTo(container);
    cardExpMonth = $("<input id='order_card_month'>").appendTo(container);
    cardExpMonth = $("<input id='order_card_year'>").appendTo(container);
    cardCvc = $("<input id='order_card_cvc'>").appendTo(container);

    cardNumberValidationError =
      $("<div id='card-number-validation-error'>").appendTo(container);
    cardCvcValidationError =
      $("<div id='card-cvc-validation-error'>").appendTo(container);

    paymentError = $("<div class='payment-errors'>").appendTo(container);

    payment = IHP.Pages.Orders.Payment(form);
  });

  describe("setNumberValidationError", function() {
    it("sets the card number validation error text", function() {
      payment.setNumberValidationError("error");
      expect(cardNumberValidationError.text()).toEqual("error")
    });

    it("sets focus to the card number", function() {
      payment.setNumberValidationError("error");
      expect(cardNumber.is(":focus")).toBeTruthy();
    });
  });

  describe("setCvcValidationError", function() {
    it("sets the card cvc validation error text", function() {
      payment.setCvcValidationError("error");
      expect(cardCvcValidationError.text()).toEqual("error")
    });

    it("sets focus to the card CVC", function() {
      payment.setCvcValidationError("error");
      expect(cardCvc.is(":focus")).toBeTruthy();
    });
  });

  describe("setPaymentError", function() {
    it("sets the overall payment error text", function() {
      payment.setPaymentError("error");
      expect(paymentError.text()).toEqual("error")
    });
  });

  describe("clearErrors", function() {
    beforeEach(function() {
      cardNumberValidationError.text("error");
      cardCvcValidationError.text("error");
      paymentError.text("error");

      payment.clearErrors();
    });

    it("clears the number error", function() {
      expect(cardNumberValidationError.text()).toEqual("");
    });

    it("clears the cvc error", function() {
      expect(cardCvcValidationError.text()).toEqual("");
    });

    it("clears the payment error", function() {
      expect(paymentError.text()).toEqual("");
    });
  });

  describe("validate", function() {
    beforeEach(function() {
      spyOn(payment, "clearErrors");
    });

    it("clears all the errors", function() {
      payment.validate();
      expect(payment.clearErrors).toHaveBeenCalled();
    });

    describe("when an existing card is selected", function() {
      beforeEach(function() {
        newCard.prop("checked", false);
      });

      it("returns true", function() {
        expect(payment.validate()).toBeTruthy();
      });
    });

    describe("when a new card is selected", function() {
      beforeEach(function() {
        newCard.prop("checked", true);
        spyOn(payment, "setNumberValidationError");
        spyOn(payment, "setCvcValidationError");
      });

      describe("when card number is missing", function() {
        var result;

        beforeEach(function() {
          payment.cardNumber.val("");
          result = payment.validate();
        });

        it("sets number validation error", function() {
          expect(payment.setNumberValidationError).
            toHaveBeenCalledWith("please enter credit card number");
        });

        it("returns false", function() {
          expect(result).toBeFalsy();
        });
      });

      describe("when card number is invalid", function() {
        var result;

        beforeEach(function() {
          payment.cardNumber.val("1234123412341234");
          result = payment.validate();
        });

        it("sets number validation error", function() {
          expect(payment.setNumberValidationError).
            toHaveBeenCalledWith("invalid credit card number");
        });

        it("returns false", function() {
          expect(result).toBeFalsy();
        });
      });

      describe("when missing CVC", function() {
        var result;

        beforeEach(function() {
          payment.cardNumber.val("4242424242424242");
          payment.cardCvc.val("");
          result = payment.validate();
        });

        it("sets number validation error", function() {
          expect(payment.setCvcValidationError).
            toHaveBeenCalledWith("please enter 3-digit CVC");
        });

        it("returns false", function() {
          expect(result).toBeFalsy();
        });
      });

      describe("when CVC is short", function() {
        var result;

        beforeEach(function() {
          payment.cardNumber.val("4242424242424242");
          payment.cardCvc.val("12");
          result = payment.validate();
        });

        it("sets number validation error", function() {
          expect(payment.setCvcValidationError).
            toHaveBeenCalledWith("please enter 3-digit CVC");
        });

        it("returns false", function() {
          expect(result).toBeFalsy();
        });
      });

      describe("when card and CVC are valid", function() {
        var result;

        beforeEach(function() {
          payment.cardNumber.val("4242424242424242");
          payment.cardCvc.val("123");
          result = payment.validate();
        });

        it("doesn't set the number validation error", function() {
          expect(payment.setNumberValidationError).not.toHaveBeenCalled();
        });

        it("doesn't set the CVC validation error", function() {
          expect(payment.setCvcValidationError).not.toHaveBeenCalled();
        });

        it("returns true", function() {
          expect(result).toBeTruthy();
        });
      });
    });
  });
});
