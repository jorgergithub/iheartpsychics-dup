Module("IHP.Components.Scrollbar", function(Scrollbar) {
  "use strict";

  Scrollbar.fn.initialize = function() {
    $(".scrollbar_table").tinyscrollbar({ size: 400 });

    this.addEventListeners();
  };

  Scrollbar.fn.addEventListeners = function() {
    $(".scrollbar_table").off("mouseenter").on("mouseenter", function() {
      $(".scrollbar", this).fadeIn();
    });
    $(".scrollbar_table").off("mouseleave").on("mouseleave", function() {
      $(".scrollbar", this).fadeOut();
    });
  };
});