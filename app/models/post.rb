class Post < ApplicationRecord
  has_many_attached :main_image
  before_save :capitalize_fields

  validate :acceptable_image

  validates :title, length: { maximum: 100, too_long: 'has to be less than 100 characters' }
  validates :title, length: { minimum: 5, too_short: 'has to be more than 5 characters' }

  validates :description, length: { maximum: 250, too_long: 'has to be less than 250 characters' }
  validates :description, length: { minimum: 25, too_short: 'has to be more than 25 characters' }

  # Adds default image if none attached
  after_commit :add_default_image, on: [:create, :update]

  belongs_to :user

  def acceptable_image
    return unless main_image.attached?
    main_image.each do |image|

      unless image.byte_size <= 4.megabyte
        errors.add(:main_image, "has to be less than 4MB")
      end

      acceptable_types = ["image/jpeg", "image/png"]
      unless acceptable_types.include?(image.content_type)
        errors.add(:main_image, "must be a JPEG or PNG")
      end
    end
  end

  def add_default_image
    unless main_image.attached?
      self.main_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_main_image.png")), filename: 'default_main_image.png' , content_type: "image/png")
    end
  end

  def capitalize_fields
    self.title.capitalize!
    self.description.capitalize!
  end

end
