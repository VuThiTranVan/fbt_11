class Tour < ApplicationRecord
  belongs_to :travel
  has_many :book_tours, dependent: :destroy


  delegate :name, to: :travel, allow_nil: true, prefix: true
  delegate :id, to: :travel, allow_nil: true, prefix: true
end
