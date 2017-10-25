class Place < ApplicationRecord
  has_many :travels, dependent: :destroy

  scope :order_city_desc, ->{order(city: :desc)}
end
