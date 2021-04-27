$(document).on('ready turbolinks:load', () => {
  contactAdmin();
  checkAgree();
  confirmPassword();
});

function contactAdmin() {
  $('#dont_agree').on('click', function() {
    $('#contact-admin-msg').removeClass('d-none');
    $('#agree').prop('checked', false);
  });
};

function checkAgree() {
  $('#agree').on('click', function() {
    $('#contact-admin-msg').addClass('d-none');
    $('#dont_agree').prop('checked', false);
  });
};

function confirmPassword() {
  $('#signup').on('click', function () {
    let password = $("#password").val();
    let confirmPassword = $("#password_confirmation").val();
    
    if (password != confirmPassword)
      $('#password_error_message').removeClass('d-none');
    else
      $('#contact-admin-msg').addClass('d-none');
  });
};
