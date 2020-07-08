class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id

    if @user.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:username, :email, :password, :profile_image))

    if @user.save
      redirect_to 'user_path'
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :profile_image)
  end
end
