var ready = function() {
  // datepickers
  $('#notice_incident_occurred_at_date').datepicker({
      container: $("#notice_incident_occurred_at_date").parent(),
      autoclose: true
  });

  var actual_officers = $("#officer-details #officer > input[value]").parent();
  actual_officers.parent().removeClass("hidden");

  $('#notice_number_officers').change(function() {
    // figure out which officers are already known
    var officer_details = $("#officer-details #officer > input").parent();
    var new_officers = $(officer_details).not(actual_officers)
    console.log(new_officers);

    // only ever show 3 officer fieldsets
    var officers = Math.min(parseInt($('#notice_number_officers').val(), 10), 3);

    // show more officer detail fields if the number selected
    // from the dropdown is greater than the saved officers
    if (officers >= actual_officers.length) {
      for (var i = actual_officers.length; i < officers; i++) { 
        console.log(i);
        var which_officer = "officer-" + (i + 1);
        $("#officer-details > #" + which_officer).removeClass("hidden");
      }
    }

  });
}


$(document).ready(ready);
$(document).on('page:load', ready);
