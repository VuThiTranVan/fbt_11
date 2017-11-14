class Place < ApplicationRecord
  has_many :travels

  validates :city, presence: true

  scope :order_city_desc, ->{order(city: :desc)}
end
