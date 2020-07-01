class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:id] = @post.user_id)
    @api_key = Rails.application.credentials.dig(:google, :google_api_key)
  end

  def find
    @post = Post.find_by(params[:id])
  end

  def new
     @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = Post.create(post_params)
    @post.user_id = @user.id

    location = Geocoder.search(full_address)
    @post.latitude = location.first.coordinates[0]
    @post.longitude = location.first.coordinates[1]

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
    @post.update(params.require(:post).permit(:description, :main_image, :title, :address, :city, :postcode))

    location = Geocoder.search(full_address)
    @post.latitude = location.first.coordinates[0]
    @post.longitude = location.first.coordinates[1]

    if @post.save
      redirect_to '/'
    else
      render 'new'
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
    params.require(:post).permit(:id, :main_image, :title, :description, :user_id, :address, :city, :postcode)
  end

  def full_address
    [@post.address, @post.city, @post.postcode].compact.join(', ')
  end
end
