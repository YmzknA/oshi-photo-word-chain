class Post < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true

  validates :name, length: { in: 2..20 }
  validates :body, length: { in: 0..200 }
  validates :url, length: { in: 0..2083 }

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy

  def self.all_posts
    Post.all.order(created_at: :desc)
  end
end
