$(function() {

  $('number-officers').change(function() {
  
  });

  $('form').on('click', '.add_fields', function(event) {
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });

});
