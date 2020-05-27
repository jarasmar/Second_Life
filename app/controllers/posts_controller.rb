class PostsController < ApplicationController
  before_action :require_login
  helper_method :current_user

  def show
    @posts = Post.all
  end

  def new
     @post = Post.new
  end

  def create
    @user = User.new
    @post = Post.create(post_params)
    session[:user_id] = @user.id
    redirect_to '/posts/index'
  end

  def acceptable_image
    return unless main_image.attached?

    unless main_image.byte_size <= 4.megabyte
      errors.add(:main_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end

  private
  def post_params
    params.require(:post).permit(:main_image, :title, :description)
  end
  #
  # def destroy
  #
  # end
end
