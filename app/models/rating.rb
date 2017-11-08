class Rating < ApplicationRecord
  belongs_to :travel
  belongs_to :user

  scope :newest, ->{order created_at: :desc}
  scope :by_travel, ->id {where travel_id: id}

  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :avatar, to: :user, allow_nil: true, prefix: true
end
