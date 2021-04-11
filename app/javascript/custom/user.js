$(document).on('ready turbolinks:load', () => {
	contactAdmin();
});

function contactAdmin()
{
	$('#agree').on('click', function() {
		$('#admin-msg').removeClass('d-none');
	})
}
