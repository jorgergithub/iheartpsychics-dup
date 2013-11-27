Module("IHP.Modals.SelectPaymentMethodModal", function(SelectPaymentMethodModal) {
  "use strict";

  SelectPaymentMethodModal.fn.initialize = function(attributes) {
    console.log("SelectPaymentMethodModal", attributes);
    var el = $("#select_payment_method_modal");

    this.el = el;
    this.package = attributes.package;

    console.log("el", el);
    console.log("credits", this.package.credits);

    $(".package-credits", el).html(this.package.credits);
    $(".package-price", el).html(this.package.price);

    el.data("package-id", this.package.id);

    el.find("#paypal_checkout input[type=hidden]").val(this.package.id)
  };
});
