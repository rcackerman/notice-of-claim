$(function() {
  // datepickers
  $('#screener_incident_occurred_on').datepicker({
      container: $("#screener_incident_occurred_on").parent(),
      autoclose: true
  });

  $('#notice_number_officers').change(function() {
    // only ever show 3 officer fieldsets
    var officers = Math.min(parseInt($('#notice_number_officers').val(), 10), 3);
    var officer_details = $("#officer-details");

    // hide all officer details input fields
    officer_details.children().addClass("hidden");

    // reset all officer details input fields
    officer_details.find('input:text').val('');
    officer_details.find('input:checkbox').removeAttr('checked');

    // show the correct number of officer detail fields
    for (var i = 0; i < officers; i++) { 
      var which_officer = "officer-" + (i + 1);
      $("#officer-details > #" + which_officer).removeClass("hidden");
    }
  });
});
