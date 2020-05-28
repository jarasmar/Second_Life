class ApplicationController < ActionController::Base
  before_action :require_login 
  helper_method :current_user
  helper_method :logged_in?
  
  def current_user
    User.find_by(id: session[:user_id])
  end
  

  def logged_in?
    !current_user.nil?
  end

  private
  
  def require_login
    redirect_to '/welcome' unless current_user
  end
end
