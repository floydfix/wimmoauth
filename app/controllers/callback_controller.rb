class CallbackController < ApplicationController
  layout 'authbase'
  
  def app
    @twice = params['twice'] && params['twice'] == "true"
    @thrice = params['thrice'] && params['thrice'] == "true"
    @app_key = params['id']
    @token = String.new
    if @app_key
      app = Apps.find_by_app_key(@app_key)
      if app
        @type = app.app_type
        case @type
        when 1
          @token = params['code']
        when 2
          if @twice
            @token = params['code']
          else
            params['twice'] = 'true'
            redirect_to params.merge!(:controller => :authorize, :action => :app)
            return
          end
        end
        if !@token
          @missing_token = true
        else
          params['token'] = @token
        end
        if !@missing_token
          redirect_to params.merge!(:action => :get_user_info)
        end
      end
    end
  end
  
  def get_user_info
    @token = params['token']
    @twice = params['twice'] && params['twice'] == "true"
    @thrice = params['thrice'] && params['thrice'] == "true"
    @app_key = params['id']
    @app = Apps.find_by_app_key(@app_key)
    @app_type = AppTypes.get(@app.app_type)
   end
  
  def new_app_user
    app_key = params['id']
    app = Apps.find_by_app_key(app_key)
    app_id = app.id
    token = params['token']
    user_name = params['user_name']
    user_id = params['user_id']
    if token && token.length > 0 && user_name && user_id
      old_user = AppUsers.find_by_app_id_and_user_id(app_id, user_id)
      if old_user
        if token == old_user.token
          respond_to do |format|
            format.json { render :json => { :id => old_user.id, :status => :ok, :message => "user and token already exists"}.to_json}
          end
          return
        else
          old_user.token = token
          old_user.save
          respond_to do |format|
            format.json { render :json => { :id => old_user.id, :status => :ok, :message => "token updated successfully"}.to_json}
          end
          return
        end
      end
      au = AppUsers.new
      au.id = au.generate_primary_id
      au.app_id = app_id
      au.user_id = user_id
      au.user_name = user_name
      au.token = token
      au.code = au.generate_code(app_id)
      au.code_expire = Time.now.to_i + (1000 * 10)
      if au.save
        respond_to do |format|
          format.json { render :json => { :id => au.id, :status => :ok, :message => "saved new user"}.to_json}
        end
        return
      else
        respond_to do |format|
          format.json { render :json => { :status => :error, :message => "save failed"}.to_json}
        end
        return
      end
    end
    respond_to do |format|
      format.json { render :json => { :params => params, :status => :error, :message => "something wrong with validation"}.to_json}
    end
    return
  end
end