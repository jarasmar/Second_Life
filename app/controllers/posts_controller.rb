class PostsController < ApplicationController
  before_action :require_login

  def show
    @posts = Post.all
  end

  def new
     @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = Post.create(post_params)
    @post.user_id = @user.id
    
    if @post.save
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  private
  def post_params
    user_id = @user.id
    params.require(:post).permit(:main_image, :title, :description, :user_id)
  end
  #
  # def destroy
  #
  # end
end
