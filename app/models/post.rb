class Post < ApplicationRecord
  has_one_attached :main_image
  # validate :acceptable_image
  # belongs_to :user
end
