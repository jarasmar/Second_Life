class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      sessions[:user_id] = @user.user_id
      redirect_to '/home'
    else
    redirect_to '/login'
    end
  end

  def login
  end

  def welcome
  end
end
