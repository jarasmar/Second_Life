class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username, :message => '%{value} has already been taken'
  has_many :posts
end
