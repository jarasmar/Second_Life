class Post < ApplicationRecord
  has_one_attached :main_image
  
  validate :acceptable_image
  
  validates :title, length: { maximum: 100, too_long: 'has to be less than 100 characters' }
  validates :title, length: { minimum: 5, too_short: 'has to be more than 5 characters' }
  
  belongs_to :user

  def acceptable_image
    return unless main_image.attached?
  
    unless main_image.byte_size <= 4.megabyte
      errors.add(:main_image, "has to be less than 4MB")
    end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end
end
