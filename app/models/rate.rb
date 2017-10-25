class Rate < ApplicationRecord
  belongs_to :rater, class_name: User.name
  belongs_to :rateable, polymorphic: true
end
