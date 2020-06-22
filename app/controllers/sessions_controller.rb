class SessionsController < ApplicationController
  skip_before_action :require_login
  
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
