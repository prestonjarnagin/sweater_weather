class User < ApplicationRecord
  validates :password, presence: true, :on => :create
  validates :password, confirmation: {case_sensitive: true}
  validates :email, presence: true, uniqueness: true

  has_many :user_cities
  has_many :cities, through: :user_cities
  has_secure_password
end
