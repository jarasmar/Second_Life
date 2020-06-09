class Post < ApplicationRecord
  has_one_attached :main_image
  validate :acceptable_image
  validate :acceptable_title
  validate :acceptable_description
  belongs_to :user

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

  def acceptable_title

    return unless title.length <= 0

    unless title.length <= 100
      errors.add(:title, "Title is too long or not there")
    end
  end


  def acceptable_description

    return unless description.length <= 0

    unless description.length <= 5000
      errors.add(:description, "Description is too long or not there")
    end
  end

end
