var scheduleElementFinder = function(content, $link) {
  var $tr = $link.closest("tr");
  var date = $tr.data("date");
  var $td = $tr.children("td:first");
  var rowspan = parseInt($td.attr("rowspan"), 10);

  console.info("rowspan", rowspan);

  // increases the rowspan to include this new row
  $td.attr("rowspan", rowspan + 1);

  content.attr("data-date", date);
  content.find("input[type=hidden]").val(date);

  if (rowspan <= 1) {
    // inserts after the row itself
    content.insertAfter($tr);
  }
  else {
    // inserts after the last row for this date
    content.insertAfter($tr.siblings("tr[data-date='" + date + "']:last"));
  }

  return false;
};
