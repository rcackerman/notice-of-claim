// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
//
var ready = function() {
  // datepickers
  $('#screener_incident_occurred_on').datepicker({
      container: $("#screener_incident_occurred_on").parent(),
      autoclose: true
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
