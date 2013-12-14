$(document).ready(function() {
  $('.call_summary_date').datepicker({
    format: 'yyyy-mm-dd'
  }).on('changeDate', function(e) {
    var date = $(this).val();
    console.info(date);
  });
});
