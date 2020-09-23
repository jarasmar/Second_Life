class SessionsController < ApplicationController
  skip_before_action :require_login
  before_action :redirect_if_logged_in, only: [:new, :welcome]
  
  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:notice] = "Invalid username/password combination"
      redirect_to '/login'
    end
  end

  def destroy      
    session[:user_id] = nil         
    redirect_to '/login' 
  end  
end
