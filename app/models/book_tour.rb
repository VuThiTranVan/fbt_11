class BookTour < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :number_person, presence: true
  before_save :calculate_total_price

  enum status: [:waiting, :accept, :finish, :cancel, :reject]

  scope :newest, ->{order created_at: :desc}
  scope :by_order_status_and_created_at, ->{order :status , created_at: :desc}
  scope :created_at_lteq, ->created_at_lteq do
    where "DATE(created_at) <= DATE(?)", created_at_lteq if created_at_lteq.present?
  end
  scope :created_at_gteq, ->created_at_gteq do
    where "DATE(created_at) >= DATE(?)", created_at_gteq if created_at_gteq.present?
  end
  scope :status_eq, ->status_eq do
    where status: BookTour.statuses.key(status_eq.to_i) if status_eq.present?
  end

  delegate :date_start, to: :tour, allow_nil: true, prefix: true
  delegate :date_end, to: :tour, allow_nil: true, prefix: true
  delegate :avatar, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true

  def calculate_total_price
    self.price = self.tour.travel.price
    self.total_price = self.price * self.number_person.to_i
  end
end
