class ApplicationController < ActionController::Base
  before_filter :get_vars
  
  # protect_from_forgery
  
  private
  
  def get_vars
    if user_signed_in? && current_user
      @apps = Apps.find_all_by_user_id(current_user.id).sort_by { |a| a.id }
    end
  end
end
