class AppsController < ApplicationController
  layout 'application'
  
  def new
    if params['Apps']
      puts params['Apps']
      @app = Apps.create()
      @app.user_id = current_user.id
      @app.app_type = 1
      @app.app_key = "123123123"
      @app.app_name = params['Apps']['app_name']
      @app.ext_app_key = params['Apps']['ext_app_key']
      @app.ext_app_secret = params['Apps']['ext_app_secret']
      @app.image = Base64.encode64(params['Apps']['image'].read)
      @app.save!
      
    elsif user_signed_in? && current_user
        
    else
      redirect_to :controller => :home
    end
  end
  
  def get
    puts params['id'];
    app = Apps.find_by_id(params['id'])
    send = Hash.new
    a = Array.new
    image = String.new
    app_key = String.new
    app.attributes.each_with_index do |f, i|
        if f[0] != 'image' && f[0] != 'created_at' && f[0] != 'updated_at'&& f[0] != 'app_type' && f[0] != 'user_id' && f[0] != 'id'
          a << f
        elsif f[0] == 'image'
          image = f[1]
        elsif f[0] == 'app_type'
          a << Array[f[0], AppTypes.find_by_id(f[1]).description]
        end
        if f[0] == 'app_key'
          app_key = f[1]
        end
    end
    a << Array["Callback url", GLOBAL_REDIRECT_URL + app_key.to_s]
    send[:json] = a
    send[:image] = image
    send[:app_test] = GLOBAL_AUTH_URL + app_key
    respond_to do |format|
      format.html
      format.json  { render :json => send.to_json }
    end
  end
end
