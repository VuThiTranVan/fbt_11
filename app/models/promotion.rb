class Promotion < ApplicationRecord
  has_many :travels, dependent: :destroy
end
