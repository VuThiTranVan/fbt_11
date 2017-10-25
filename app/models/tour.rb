class Tour < ApplicationRecord
  belongs_to :travel
  has_many :book_tours, dependent: :destroy

  scope :start_date_greater_today, ->{where "DATE(tours.date_start) > CURDATE()"}

  delegate :name, to: :travel, allow_nil: true, prefix: true
  delegate :id, to: :travel, allow_nil: true, prefix: true
end
