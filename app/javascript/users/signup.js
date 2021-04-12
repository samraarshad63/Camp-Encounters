$(document).on('ready turbolinks:load', () => {
	contactAdmin();
});

function contactAdmin() {
	$('#agree').on('click', function() {
		$('#contact-admin-msg').removeClass('d-none');
	});
};
