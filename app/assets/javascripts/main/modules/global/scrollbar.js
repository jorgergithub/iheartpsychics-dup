Module("IHP.Components.Scrollbar", function(Scrollbar) {
  "use strict";

  Scrollbar.fn.MAX_HEIGHT = 450;

  Scrollbar.fn.initialize = function() {
    this.elements = $(".scrollbar_table");
    
    this.assign();
    this.addEventListeners();
  };

  Scrollbar.fn.assign = function() {
    $.each(this.elements, function(index, element) {
      var viewport = $(".viewport", element);

      var tableHeight = $("table", element).height();
      var options = {}

      if (tableHeight > this.MAX_HEIGHT) {
        viewport.css("height", "450px");
        options["size"] = this.MAX_HEIGHT - 50
        
      } else {
        viewport.css("height", tableHeight + "px");
        options["size"] = 0
      };

      $(element).tinyscrollbar(options);
    }.bind(this));
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