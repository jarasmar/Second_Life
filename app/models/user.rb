class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image

  validates :username, :email, :password, presence: true
  
  validates_uniqueness_of :username, :message => '%{value} has already been taken'
  validates_uniqueness_of :email, :message => '%{value} has already been taken'
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: { in: 5..20 }
  
  has_many :posts
end
