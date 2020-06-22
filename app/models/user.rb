class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image

  validates :username, :email, :password, presence: true
  
  validates_uniqueness_of :username, :message => '%{value} has already been taken'
  validates_uniqueness_of :email, :message => '%{value} has already been taken'
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: { in: 5..20 }
  
  # Adds default image if none attached
  after_commit :add_default_image, on: [:create, :update]
  
  has_many :posts

  def add_default_image
    unless profile_image.attached?
      self.profile_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_profile.png")), filename: 'default_profile.png' , content_type: "image/png")
    end
  end
end
