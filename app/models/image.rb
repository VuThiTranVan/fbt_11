class Image < ApplicationRecord
  belongs_to :travel
  mount_uploader :picture, PictureUploader
end
