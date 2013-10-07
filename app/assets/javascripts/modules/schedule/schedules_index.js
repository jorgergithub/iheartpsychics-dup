Module("IHP.Pages.SchedulesIndex", function(SchedulesIndex) {
  "use strict";

  SchedulesIndex.fn.initialize = function(el) {
    console.debug("initialized", el);
    this.el = $(el);

    this.addEventListeners();
  };

  SchedulesIndex.fn.addEventListeners = function() {
    this.el.find(".add_schedule").on("click", this.addSchedule.bind(this));
  };

  SchedulesIndex.fn.addSchedule = function(e) {
    e.stopPropagation();
    e.preventDefault();

    var button = $(e.target);
    var date = button.data("date");

    console.debug(date);
  };
});
