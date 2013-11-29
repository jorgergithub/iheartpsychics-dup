Module("IHP.Pages.Schedules", function(Schedules) {
  "use strict";

  Schedules.fn.initialize = function(el) {
    this.el = $($(el).find(".schedules"));
    this.addEventListeners();

    this.zebrateTable();
  };
  
  Schedules.fn.addEventListeners = function() {
    this.el.on("click", ".add-schedule", this.addSchedule.bind(this));
    this.el.on("click", ".remove-schedule", this.removeSchedule.bind(this));
    this.el.on("click", "div.upcoming-time", this.showPopover.bind(this));
    this.el.on("input", ".popover input", this.updateTimeDisplay);
    this.el.on("change", ".popover input", this.updateTimeDisplay);
    this.el.on("click", this.dismissPopovers);
    this.el.on("click", ".popover", this.stopPropagation.bind(this));
  };

  Schedules.fn.updateTimeDisplay = function(e) {
    var $popover = $(this).closest(".popover");
    var $time = $popover.siblings(".upcoming-time");
  
    var $timeString = $("input.time_string", $time);
    var $span = $("span.time", $time);

    var hour = $("input.hour", $popover).val();
    var minute = $("input.minute", $popover).val();
    var period = $("input.toggle", $popover).is(":checked") ? "PM" : "AM";

    hour   = hour ? hour : "00"
    minute = minute ? minute : "00"

    var value = hour + ":" + minute + " " + period
    $span.text(value);
    $timeString.val(value);
  }

  Schedules.fn.dismissPopovers = function() {
    $(".popover").hide();
  };

  Schedules.fn.stopPropagation = function(e) {
    e.stopPropagation();
  }

  Schedules.fn.showPopover = function(e) {
    e.preventDefault();
    e.stopPropagation();

    var $time = $(e.target).closest(".upcoming-time");
    var $popover = $time.siblings(".popover");
  
    if ($popover.is(":hidden")) {
      this.dismissPopovers();
      $popover.show();
      $("input.hour", $popover).focus();
      $("input.hour", $popover).select();
    } else {
      this.dismissPopovers();
    }
  };

  Schedules.fn.addScheduleRow = function(date, el) {
    var template = $("#new_schedule").html();
    var newId = new Date().getTime();
    var regex = new RegExp("new_schedules", "g");
    var content = $(template.replace(regex, newId));

    content.attr("data-date", date);
    content.find("input[type=hidden].date").val(date);
    content.insertAfter(el);
    this.zebrateTable();

    return content;
  };

  Schedules.fn.addSchedule = function(e) {
    e.preventDefault();

    var $link = $(e.target);
    var date = $link.data("date");

    var $schedule = $link.closest("tr");
    var $td = $schedule.children("td:first");

    this.changeRowspanBy($td, 1);
    this.addScheduleRow(date, $schedule);
  };

  Schedules.fn.removeSchedule = function(e) {
    e.preventDefault();

    var $link = $(e.target);
    var $schedule = $link.closest("tr.fields-row");

    var $dateRow = $schedule.prevAll("tr.date-row").first();
    var $dateCell = $("td.upcoming-date", $dateRow);

    if (this.dateHasOneSchedule($dateRow)) { 
      this.resetSchedule($schedule); 
    } else {
      this.changeRowspanBy($dateCell, -1)
      $schedule.hide();
      this.zebrateTable();
    } 

    $("input.delete", $schedule).val(true);
  };

  Schedules.fn.dateHasOneSchedule = function(dateRow) {
    return $(dateRow).nextUntil("tr.date-row", ":visible").length === 1
  }

  Schedules.fn.resetSchedule = function(schedule) {
    var $schedule = $(schedule);

    $("span.time", $schedule).text("");
    $("input.hour", $schedule).val("");
    $("input.minute", $schedule).val("");
    $("input.toggle", $schedule).attr("checked",false);
  }

  Schedules.fn.changeRowspanBy = function(td, amount) {
    var rowspan = parseInt(td.attr("rowspan"), 10);
    td.attr("rowspan", rowspan + amount);
  }

  Schedules.fn.zebrateTable = function() {
    $("tbody tr.date-row + tr.fields-row", this.el).addClass("first-schedule");
    $("tbody tr.fields-row:visible", this.el).removeClass("zebra");
    $("tbody tr.fields-row:visible:even", this.el).addClass("zebra");
  }
});