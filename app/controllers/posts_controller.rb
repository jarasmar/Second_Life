class PostsController < ApplicationController
  before_action :require_login

  def show
    @post = Post.find(params[:id])
  end

  def new
     @post = Post.new
  end

  # def create
  #   @post = Post.create({})
  # end
  #
  # def destroy
  #
  # end
end
