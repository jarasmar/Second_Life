class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :email, :password, :profile_image))
    session[:user_id] = @user.id

    if @user.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @user_posts = Post.where(user_id: current_user.id)
  end
end
