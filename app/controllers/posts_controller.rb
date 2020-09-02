class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:id] = @post.user_id)
    @api_key = Rails.application.credentials.dig(:google, :google_api_key)
  end

  # def find
  #   @post = Post.find_by(params[:id])
  # end

  def new
     @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = Post.create(post_params)
    @post.user_id = @user.id

    if @post.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post).permit(:description, :title, :address, :city, :postcode, :latitude, :longitude, :items, main_image: []))

    if @post.save
      redirect_to '/'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end

  private
  def post_params
    user_id = @user.id
    params.require(:post).permit(:id, :title, :description, :user_id, :address, :city, :postcode, :latitude, :longitude, :items, main_image: [])
  end
end
