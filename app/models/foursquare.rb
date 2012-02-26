class Foursquare < AppTypes
  def description
    return "Foursquare"
  end
  
  def last
    return 2
  end
  
  def oauth_path
    return "https://foursquare.com/oauth2/authenticate";
  end
  
  def params
    return {'client_id' => 'ext_app_key', 'redirect_uri' => 'url'}
  end
  
  def params_end
    return "response_type=token&v=20120223"
  end
  
  def get_user_path
    return "https://api.foursquare.com/v2/users/self"
  end
  
  def get_user_params
    return "oauth_token"
  end
  
  def get_user_params_end
    return "v=20120223"
  end
end
