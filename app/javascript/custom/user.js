$(document).on('ready turbolinks:load', () => {
	contactAdmin();
});

function contactAdmin()
{
	$('#dont-agree-check').on('change', function() {
		$('#admin-msg').removeClass('d-none');
	})
}