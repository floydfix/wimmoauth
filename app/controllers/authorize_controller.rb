class AuthorizeController < ApplicationController
  layout 'authbase'
  
  def app
    @app_key = params['id']
    @twice = params['twice'] && params['twice'] == "true"
    @thrice = params['thrice'] && params['thrice'] == "true"
    code = params['code']
    if @app_key
      @app = Apps.find_by_app_key(@app_key)
      if @app
        @app_id = @app.id.to_s
        @app_type = AppTypes.get(@app.app_type)
        if @app_type
          params = Array.new
          if @twice
            oauth_path = @app_type.oauth_path_2
            parameters = @app_type.params_2
            parameters_end = @app_type.params_end_2
          elsif @thrice
            oauth_path = @app_type.oauth_path_3
            parameters = @app_type.params_3
            parameters_end = @app_type.params_end_3
          else
            oauth_path = @app_type.oauth_path
            parameters = @app_type.params
            parameters_end = @app_type.params_end
          end
          parameters.each_pair do |k, v|
            param = k + "="
            if v == 'url'
              param += GLOBAL_REDIRECT_URL + @app_key
            elsif v == 'code'
              param += code
            else
              param += @app[v]
            end
            params << param
          end
          if parameters_end !=nil
            params << parameters_end 
          end
          @oauth_url = oauth_path
          if params.length > 0
            @oauth_url += "?"
            params.each_with_index do |p,i|
              @oauth_url += p
              if i < params.size - 1
                @oauth_url += "&"
              end
            end
          end
        end
      end
    end
    if @app_type
      if (@twice && @app_type.last == 2) || (@thrice && @app_type.last == 3) || @app_type.last == 1
        pars = Hash.new
        if @twice
          pars['twice'] = 'true'
        elsif
          pars['thrice'] = 'true'
        end
        params.each do |p|
          if p.include? '&'
            p.split('&').each do |p|
              pair = p.split('=')
              pars[pair[0]] = pair[1]
            end
          else
            pair = p.split('=')
            pars[pair[0]] = pair[1]
          end
        end
        # puts pars.inspect
        redirect_to pars.merge!(:controller => :callback, :action => :app, :id => @app_key)
      end
    end
  end
end