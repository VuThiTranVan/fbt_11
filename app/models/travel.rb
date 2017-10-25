class Travel < ApplicationRecord
  belongs_to :place_from, class_name: Place.name, foreign_key: :id_place_from
  belongs_to :place_to, class_name: Place.name, foreign_key: :id_place_to
  belongs_to :promotion, optional: true
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tours, dependent: :destroy
  has_many :ratings, dependent: :destroy

  scope :all_travels, ->{joins(:images).order created_at: :desc}
end
