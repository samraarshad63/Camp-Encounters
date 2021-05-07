$( document ).ready(function() {
  $('#popup').click(function() {
    event.preventDefault();
    $('#confirmation-modal').modal('show');
  });
});
