class BookTour < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :number_person, presence: true

  enum status: [:waiting, :accept, :finish, :cancel]

  scope :order_created_desc, ->{order created_at: :desc}
end
