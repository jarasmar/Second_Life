class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :redirect_if_logged_in, :only => [:new]
  
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
    # @post = Post.find(params[:id])
    @user = User.find(params[:id])
    @user_posts = Post.where(user_id: @user.id)
  end

end
