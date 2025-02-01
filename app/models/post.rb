class Post < ApplicationRecord
  validates :name, presence: true
  validates :body, presence: true

  mount_uploader :image, ImageUploader
end
