class Place < ApplicationRecord
  has_many :travels, dependent: :destroy
end
