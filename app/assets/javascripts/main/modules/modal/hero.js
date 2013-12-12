Module("IHP.Modals.HeroModal", function(Modal) {
  "use strict";

  Modal.fn.initialize = function(attributes) {
    this.el = $("#hero_modal", "body");
    this.addEventListeners();

    this.el.html(this.video());
  };

  Modal.fn.video = function() {
    return $('<iframe width="640" height="360" src="//www.youtube.com/embed/H7jtC8vjXw8?rel=0" frameborder="0" allowfullscreen></iframe>');
  };

  Modal.fn.addEventListeners = function() {
    this.el.off("dismiss").on("dismiss", function() {
      this.el.find("iframe").remove();
    }.bind(this));
  };
});