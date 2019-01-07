class City < ApplicationRecord
  validates :name, presence: true

  has_many :user_cities, dependent: :destroy
  has_many :users, through: :user_cities

end
