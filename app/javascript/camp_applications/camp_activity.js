$(document).on('ready turbolinks:load', () => {
  checkActivityParticipation();
  checkActivityContribution();
});

function checkActivityParticipation() {
  $('#want_to_participate').on('click', function() {
    $('#display-activity-list').removeClass('d-none');
  });
};

function checkActivityContribution() {
  $('#want_to_contribute').on('click', function() {
    $('#display-contribution-field').removeClass('d-none');
  });
};
