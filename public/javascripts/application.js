$(document).ready(function(){
	
	$('.app').live('click', function(){
		if($(this).hasClass('not-selected')){
			obj = $(this);
			$('.app').removeClass('selected');
			$('.app').addClass('not-selected');
			obj.removeClass('not-selected');
			obj.addClass('selected');
			fill_app(obj);
		}
	});
	
	$('.app.selected').each(function(i){
		fill_app($(this));
	});
	if($('#missing_token').length > 0 && window.location.hash) {
		var token = window.location.hash.substring(1).split('=')[1];
		window.location.href = '/callback/app/'+ $('#app_key').val() +'?code=' + token + '&twice=' + ($('#twice').length > 0) + '&thrice=' + ($('#thrice').length > 0);
	} else {
	
	}
	
	var timer = $('#time_till_expire');
	if(timer.length > 0){
		timer.countdown({until: parseInt($('.10minutes').html()) * 1000, format: 'Ms'});
		console.debug(Date.now());
		console.debug(parseInt($('.10minutes').html()) * 1000);
	}
});

function fill_app(obj){
	var app_id = obj.data('app_id');
	if(app_id != undefined){
		$.ajax({
			type: 'POST',
			url: 'apps/get',
			data: {id: app_id},
			success: function(data){
				$('#Results').empty();
				$('#Results').append(CreateTableView(data.json)).fadeIn();
				$('#Results thead').remove();
				//$('#callback_url').html("localhost:3000/callback/" + data.id);
				// //console.debug(data);
				$('#app_image').attr('src', 'data:image/png;base64,' + data.image)
				$('tr:even').css({'background-color':'#222'})
				$('#app_test').attr('href',data.app_test).html("Test App")
			},
			dataType: 'json'
			});
		}
}

