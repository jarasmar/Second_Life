class Post < ApplicationRecord
  has_one_attached :main_image
  validate :acceptable_image
  # belongs_to :user

  def acceptable_image
    return unless main_image.attached?
  
    unless main_image.byte_size <= 4.megabyte
      errors.add(:main_image, "Image is too big")
    end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, "Image must be a JPEG or PNG")
    end
  end
end
