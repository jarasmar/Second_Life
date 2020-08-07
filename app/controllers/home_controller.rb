class HomeController < ApplicationController

  def index
    @posts = Post.all
  end

  def map
    @posts = Post.all
    @api_key = Rails.application.credentials.dig(:google, :google_api_key)
  end

end
