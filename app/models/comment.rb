class Comment < ApplicationRecord
  belongs_to :travel
  belongs_to :user
  belongs_to :category
  has_many :likes
end
