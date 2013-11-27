Module("IHP.Modals.SelectPaymentMethodModal", function(SelectPaymentMethodModal) {
  "use strict";

  SelectPaymentMethodModal.fn.initialize = function(attributes) {
    this.el = $("#select_payment_method_modal");
    this.package = attributes.package;

    this.assign();
    this.setPackage();
    this.initNewCreditCardPayment();
    this.bindNavigation();
    this.cardSelection();
  };

  SelectPaymentMethodModal.fn.assign = function() {
    $(".new_credit_card_panel form", this.el)[0].reset();
  };

  SelectPaymentMethodModal.fn.setPackage = function() {
    $(".package-credits", this.el).html(this.package.credits);
    $(".package-price", this.el).html(this.package.price);
    this.el.data("package-id", this.package.id);
    this.el.find("form input[name='order[package_id]']").val(this.package.id)
  };

  SelectPaymentMethodModal.fn.initNewCreditCardPayment = function(attributes) {
    var form = this.el.find(".new_credit_card_panel form")
    Module.run("IHP.Main.Modal.Payment", form);
  };

  SelectPaymentMethodModal.fn.bindNavigation = function(attributes) {
    this.el.off("click", "nav li").on("click", "nav li", function() {
      $(this).siblings().removeClass("tab_selected");
      $(this).addClass("tab_selected");
    });

    this.el.off("click", "li[data-panel], a[data-panel]").on("click", "li[data-panel], a[data-panel]", function() {
      var panel = $(this).data("panel");
      $(".modal_panel").hide();
      $(".modal_panel." + panel).show();
    });
  };

  SelectPaymentMethodModal.fn.cardSelection = function(attributes) {
    this.el.off("click", "ul.credit_cards li").on("click", "ul.credit_cards li", function(e) {
      e.preventDefault();
      $(this).siblings().removeClass("cc_selected");
      $(this).addClass("cc_selected");
    });
  };
});
