Module("IHP.Components.Scrollbar", function(Scrollbar) {
  "use strict";

  Scrollbar.fn.MAX_TABLE_HEIGHT = function() { return 450 };
  Scrollbar.fn.MAX_MODAL_HEIGHT = function() { return $(window).height() * 0.7 };

  Scrollbar.fn.initialize = function() {
    this.tables = $(".scrollbar_table");
    this.modals = $(".scrollbar_modal");
    
    this.assign();
    this.addEventListeners();
  };

  Scrollbar.fn.assign = function() {
    $.each(this.tables, function(index, table) {
      var viewport = $(".viewport", table);
      var height = $("table", table).height();
      var options = {}

      this.setHeight(this.MAX_TABLE_HEIGHT(), height, viewport, options)

      $(table).tinyscrollbar(options);
    }.bind(this));


    $.each(this.modals, function(index, modal) {
      var viewport = $(".viewport", modal);

      var height = $(".modal-body", modal).height();
      var options = {}

      this.setHeight(this.MAX_MODAL_HEIGHT(), height, viewport, options)

      $(modal).tinyscrollbar(options);
    }.bind(this));
  };

  Scrollbar.fn.setHeight = function(maxHeight, height, viewport, options) {
    console.log(maxHeight);
    console.log(height);
    if (height > maxHeight) {
      console.log("com scroll");
      viewport.css("height", maxHeight + "px");
      options["size"] = maxHeight - 50
    } else {
      console.log("sem scroll");
      options["size"] = 0
    };
  }

  Scrollbar.fn.addEventListeners = function() {
    $(".scrollbar_table").off("mouseenter").on("mouseenter", function() {
      $(".scrollbar", this).fadeIn();
    });
    $(".scrollbar_table").off("mouseleave").on("mouseleave", function() {
      $(".scrollbar", this).fadeOut();
    });
  };
});