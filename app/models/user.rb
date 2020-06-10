class User < ApplicationRecord
  has_secure_password
  
  validates_uniqueness_of :username, :message => '%{value} has already been taken'
  validates_uniqueness_of :email, :message => '%{value} has already been taken'
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  has_many :posts
end
