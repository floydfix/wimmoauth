class Facebook < AppTypes
  def description
    return "Facebook"
  end

  def last
    return 3
  end
  
  def oauth_path
    return "https://www.facebook.com/dialog/oauth";
  end
  
  def params
    return {'client_id' => 'ext_app_key', 'redirect_uri' => 'url'}
  end
  
  def params_end
    return "scope=email,read_stream,offline_access"
  end
  
  def oauth_path_2
    return "https://graph.facebook.com/oauth/access_token";
  end
  
  def params_2
    return {'client_id' => 'ext_app_key', 'redirect_uri' => 'url', 'client_secret' => 'ext_app_secret', 'code' => 'code'}
  end
  
  def params_end_2
    return "response_type=token&v=20120223"
  end
  
  def get_user_path
    return "https://graph.facebook.com/me"
  end
  
  def get_user_params
    return "access_token"
  end
  
  def get_user_params_end
    return ""
  end
  
end
