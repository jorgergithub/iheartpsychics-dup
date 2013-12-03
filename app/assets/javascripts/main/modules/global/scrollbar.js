Module("IHP.Components.Scrollbar", function(Scrollbar) {
  "use strict";

  Scrollbar.fn.MAX_TABLE_HEIGHT = 450;
  Scrollbar.fn.MAX_MODAL_HEIGHT = 450;

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

      this.setHeight(this.MAX_TABLE_HEIGHT, height, viewport, options)

      $(table).tinyscrollbar(options);
    }.bind(this));


    $.each(this.modals, function(index, modal) {
      var viewport = $(".viewport", modal);

      var height = $(".modal-body", modal).height();
      var options = {}

      this.setHeight(this.MAX_MODAL_HEIGHT, height, viewport, options)

      $(modal).tinyscrollbar(options);
    }.bind(this));
  };

  Scrollbar.fn.setHeight = function(maxHeight, height, viewport, options) {
    if (height > maxHeight) {
      if (maxHeight === 200) {
        console.log("grande");
        viewport.css("height", height + "px");
      }
      viewport.css("height", maxHeight + "px");
      options["size"] = maxHeight - 50
    } else {
      if (maxHeight === 200) {
        console.log("pikeno");
        viewport.css("height", height + "px");
      }
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