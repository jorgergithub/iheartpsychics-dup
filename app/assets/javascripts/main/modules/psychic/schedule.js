Module("IHP.Pages.Schedules", function(Schedules) {
  "use strict";

  Schedules.fn.initialize = function(el) {
    this.el = $($(el).find(".schedules"));
    this.addEventListeners();
  };

  Schedules.fn.addEventListeners = function() {
    this.el.on("click", ".add-schedule", this.addSchedule.bind(this));
    this.el.on("click", ".remove-schedule", this.removeSchedule.bind(this));
  };

  Schedules.fn.addScheduleRow = function(date, el) {
    var template = $("#new_schedule").html();
    var newId = new Date().getTime();
    var regex = new RegExp("new_schedules", "g");
    var content = $(template.replace(regex, newId));

    content.attr("data-date", date);
    content.find("input[type=hidden].date").val(date);
    content.insertAfter(el);

    return content;
  };

  Schedules.fn.addSchedule = function(e) {
    e.stopPropagation();
    e.preventDefault();

    var link = $(e.target);
    var date = link.data("date");

    var tr = link.closest("tr");
    var td = tr.children("td:first");

    var rowspan = parseInt(td.attr("rowspan"), 10);

    td.attr("rowspan", rowspan + 1);

    if (rowspan <= 1) {
      this.addScheduleRow(date, tr);
    }
    else {
      var lastTr = tr.siblings("tr[data-date='" + date + "']:last");
      this.addScheduleRow(date, lastTr);
    };
  };

  Schedules.fn.removeSchedule = function(e) {
    e.stopPropagation();
    e.preventDefault();

    var link = $(e.currentTarget);
    console.log(link);

    var tr = link.parents("tr");
    console.log(tr);

    var date = tr.data("date");
    console.log(date);

    var firstTr = tr.parent().find("tr[data-date='" + date + "']:first");
    console.log(firstTr);

    if (!firstTr.length) {
      firstTr = tr;
    }

    var td = firstTr.children("td:first");
    console.log(td);

    var rowspan = parseInt(td.attr("rowspan"), 10);
    console.log(rowspan);

    td.attr("rowspan", rowspan - 1);
    link.prev("input[type=hidden]").val("1");

    if (tr.children("td").length == 3) {
      var siblings = tr.siblings("tr[data-date='" + date + "']");
      if (siblings.length > 0) {
        var sourceTr = $(siblings[0]);
        var targetTr = tr;
        // targetTr.find("input.start_time").val(sourceTr.find("input.start_time").val());
        // targetTr.find("input.end_time").val(sourceTr.find("input.end_time").val());
        sourceTr.find("input[type=hidden].delete").val("1");
        targetTr.find("input[type=hidden].delete").val("0");
        sourceTr.hide();
      }
      else {
        // tr.find("input.start_time").val("");
        // tr.find("input.end_time").val("");
      }
    } else {
      console.log("1");
      tr.hide();
    }
  };
});
