class Tour < ApplicationRecord
  belongs_to :travel
  has_many :book_tours, dependent: :destroy
end
