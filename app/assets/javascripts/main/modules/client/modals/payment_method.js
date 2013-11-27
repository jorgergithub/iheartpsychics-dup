Module("IHP.Modals.SelectPaymentMethodModal", function(SelectPaymentMethodModal) {
  "use strict";

  SelectPaymentMethodModal.fn.initialize = function(attributes) {
    console.log("SelectPaymentMethodModal", attributes);
    var el = $("#select_payment_method")

    this.el = el;
    this.package = attributes.package;

    console.log("el", el);
    console.log("credits", this.package.credits);

    $(".package-credits").html(this.package.credits);
    $(".package-price").html(this.package.price);
  };
});
