class PostsController < ApplicationController

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
      flash.now[:alert] = "Image must be less than 4MB and JPEG/PNG format."
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update 
    @post = Post.find(params[:id])
    @post.update(params.require(:post).permit(:description, :main_image, :title))
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/posts'
  end

  private
  def post_params
    user_id = @user.id
    params.require(:post).permit(:main_image, :title, :description, :user_id)
  end
end
