$(function() {
  $('#notice_number_officers').change(function() {
    // only ever show 3 officer fieldsets
    var officers = Math.min(parseInt($('#notice_number_officers').val(), 10), 3);
    var regexp = new RegExp($(this).data('id'), 'g');

    console.log(officers);

    for (var i = 0; i < officers; i++) { 
      var which_officer = "officer-" + (i + 1);
      event.preventDefault();
    }
  });
  //$(this).after($(this).data('fields').replace(regexp, which_officer));
});
