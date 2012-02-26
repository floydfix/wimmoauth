$(document).ready(function(){
	
	if($('#twice').length > 0 || $('#thrice').length > 0){
		var url = $('#oauth_url').val();
		console.debug(url);
		$.ajax({
			type: 'GET',
			url: url,
			data: '',
			success: function(data){
				console.debug(data);
				get_user(data.responseText.split('=')[1]);
			},
			error: function(data){
				console.debug(data);
				get_user(data.responseText.split('=')[1]);
			},
			dataType: 'json'
		});
	}
});

function get_user(token){
	window.location.href = '/callback/app/'+ $('#app_key').val() +'?code=' + token + '&twice=' + ($('#twice').length > 0) + '&thrice=' + ($('#thrice').length > 0);
}
