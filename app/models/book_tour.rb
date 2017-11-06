class BookTour < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :number_person, presence: true
  before_save :calculate_total_price

  enum status: [:waiting, :accept, :finish, :cancel, :reject]

  scope :newest, ->{order created_at: :desc}

  delegate :date_start, to: :tour, allow_nil: true, prefix: true
  delegate :date_end, to: :tour, allow_nil: true, prefix: true

  def calculate_total_price
    self.price = self.tour.travel.price
    self.total_price = self.price * self.number_person.to_i
  end
end
