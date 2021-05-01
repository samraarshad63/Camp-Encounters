$(document).on('ready turbolinks:load', () => {
  checkActivityParticipation();
  checkActivityContribution();
});

function checkActivityParticipation() {
  $('#want_to_participate').on('click', function() {
    $('#display-activity-list').removeClass('d-none');
    $('#check-contribution').addClass('d-none');
    $('#dont_want_to_participate').prop('checked', false);
  });

  $('#dont_want_to_participate').on('click', function() {
    $('#check-contribution').removeClass('d-none');
    $('#display-activity-list').addClass('d-none');
    $('#want_to_participate').prop('checked', false);
  });
};

function checkActivityContribution() {
  $('#want_to_contribute').on('click', function() {
    $('#display-contribution-field').removeClass('d-none');
    $('#dont_want_to_contribute').prop('checked', false);
  });

  $('#dont_want_to_contribute').on('click', function() {
    $('#display-contribution-field').addClass('d-none');
    $('#want_to_contribute').prop('checked', false);
  });
};
