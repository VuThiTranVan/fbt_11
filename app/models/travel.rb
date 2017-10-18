class Travel < ApplicationRecord
  belongs_to :place_from, class_name: Place.name, foreign_key: :id_place_from
  belongs_to :place_to, class_name: Place.name, foreign_key: :id_place_to
  belongs_to :promotion
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tours, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validats :promotion, allow_nil: true
end
