$( document ).ready(function() {
  $('#popup').click(function() {
    event.preventDefault();
    $('#myModal').modal('show');
  });
});
