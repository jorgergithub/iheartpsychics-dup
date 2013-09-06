describe("IHP.Pages.OrdersNew", function() {
  var container, submit, cancel;
  var package, payment, orders_new;

  beforeEach(function() {
    container = $("<div/>").appendTo(".output")
    form = $("<form onsubmit='return false;' />").appendTo(container);
    submit = $("<button class='go'>").appendTo(form);
    cancel = $("<a class='cancel'>").appendTo(form);

    package = jasmine.createSpyObj("package", ["validate"]);
    payment = jasmine.createSpyObj("payment", ["validate"]);

    spyOn(IHP.Pages.Orders, "Package").and.callReturn(package);
    spyOn(IHP.Pages.Orders, "Payment").and.callReturn(payment);

    orders_new = IHP.Pages.OrdersNew(container);
  });

  describe("when the form is submitted", function() {
    var event;

    beforeEach(function() {
      event = $.Event;
      event.type = "submit";
    });

    it("validates the package", function() {
      form.trigger(event);
      expect(package.validate).toHaveBeenCalled();
    });

    it("validates the payment", function() {
      package.validate.and.callReturn(true);

      form.trigger(event);
      expect(payment.validate).toHaveBeenCalled();
    });
  });
});
