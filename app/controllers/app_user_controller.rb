class AppUserController < ApplicationController
  layout 'authbase'
  
  def show
    id = params['id']
    @user = AppUsers.find_by_id(id)
  end

  def error
    @message = params['message']
    @link = params['link_back']
    
  end
end