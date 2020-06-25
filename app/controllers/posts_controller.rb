class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:id] = @post.user_id)
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
    response = ('https://maps.googleapis.com/maps/api/geocode/json', {
      params: {
        address: params[:location],
        key: '<%= Rails.application.credentials.dig(:google, :google_api_key) %>'
      }
    })
    @post.lat = response.data.results[0].geometry.location.lat
    @post.lng = response.data.results[0].geometry.location.lng

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
    @post.update(params.require(:post).permit(:description, :main_image, :title))

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
    params.require(:post).permit(:id, :main_image, :title, :description, :user_id, :location)
  end
end
