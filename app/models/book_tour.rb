class BookTour < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :number_person, presence: true
end
