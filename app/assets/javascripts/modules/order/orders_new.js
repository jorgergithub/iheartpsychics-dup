Module("IHP.Pages.OrdersNew", function(OrdersNew) {
  "use strict";

  OrdersNew.fn.initialize = function(el) {
    Emitter.extend(this);

    // order form
    this.form = $(el).find("form");

    // form buttons
    this.submit = this.form.find("button.go");
    this.cancel = this.form.find("a.cancel");

    // sub components
    this.package = IHP.Pages.Orders.Package(this.form);
    this.payment = IHP.Pages.Orders.Payment(this.form);

    this.addEventListeners();
  };

  OrdersNew.fn.addEventListeners = function() {
    this.form.on("submit", this.whenFormSubmitted.bind(this));
  };

  OrdersNew.fn.whenFormSubmitted = function() {
    return this.package.validate() && this.payment.validate();
  };

  OrdersNew.fn.disableButtons = function() {
    this.submit.prop("disabled", true);
    this.cancel.hide();
  };

  OrdersNew.fn.enableButtons = function() {
    this.submit.prop("disabled", false);
    this.cancel.show();
  };

  OrdersNew.fn.process = function() {
    if (!this.validate()) {
      return false;
    }

    this.disableButtons();
    this.payment.process();
  }

  OrdersNew.fn.run = function() {
    this.form.submit(this.process.bind(this));
  }
});
