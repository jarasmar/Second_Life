class ApplicationController < ActionController::Base
  before_action :require_login 
  helper_method :current_user
  helper_method :logged_in?
  protect_from_forgery with: :null_session
  
  def current_user
    User.find_by(id: session[:user_id])
  end
  

  def logged_in?
    !current_user.nil?
  end

  def moon 
    cookies[:moon] = {
      value: 'dark mode on'
    }
    if @logged_in
      redirect current_path
    else
      redirect_to '/welcome'
    end
  end

  def sun
    cookies.delete(:moon)
    if @logged_in
      redirect_to '/'
    else
      redirect_to '/welcome'
    end
  end

  private
  
  def require_login
    redirect_to '/welcome' unless current_user
  end
end
