class User < ActiveRecord::Base
  has_many :meals
  has_many :likes
  validates :email, uniqueness: true, presence: true
  validates :user_name, uniqueness: true, presence: true
  has_secure_password # it adds two methods to user objects
end