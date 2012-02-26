$(document).ready(function(){
	var user_name = "";
	var user_id = "";
	
	var type = parseInt($('#type').val());
	var token = $('#token').val().trim();
	var app_id = $('#app_id').val().trim();
	var token_param = $('#token_param').val().trim();
	var param_end = $('#param_end').val().trim();
	get_user(type, token_param, token, param_end);
});

function get_user(type, token_param,token, param_end){

		$.ajax({
		type: 'GET',
		url: $('#get_user_path').val() + "?" + token_param +"=" + token + ((param_end.length > 0)? "&"+param_end : ""),
		success: function(data){
			if(type == 1){
				create_new_app_user(data['response']['user']['id'],data['response']['user']['firstName'] + " " + data['response']['user']['lastName'] , token);
			}else if(type == 2){
				create_new_app_user(data.id,data.name, token);
			}
		},
		error: function(data){
			console.debug(data);
			if(type == 1){
				create_new_app_user(data['response']['user']['id'],data['response']['user']['firstName'] + " " + data['response']['user']['lastName'] , token);
			}else if(type == 2){
				create_new_app_user(data.id,data.name, token);
			}
		},
		dataType: 'json'
	});
}

function create_new_app_user(id, name,token){
	$.ajax({
		type: 'POST',
		url: '../../callback/new_app_user/' + $('#app_key').val(),
		data:{'token': token,
				'user_id' : id,
				'user_name' : name},
		success: function(data){
			show_code(data);
		},
		error: function(data){
			show_code(data);
		},
		dataType: 'json'
	});
}

function show_code(data){
	if(data.status == 'ok'){
		window.location.href = "../../app_user/show/" + data.id;
	}else{
		window.location.href = "../../app_user/error?message=" + data.message;
	}
}
