class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user
  protect_from_forgery with: :null_session
  helper_method :redirect_if_logged_in

  def current_user
    User.find_by(id: session[:user_id])
  end

  private

  def require_login
    redirect_to '/welcome' unless current_user
  end

  def redirect_if_logged_in
    if current_user
      redirect_to '/'
    end
  end
end
