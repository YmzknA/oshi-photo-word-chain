class Post < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true

  # nameの長さは1文字以上50文字以下
  # bodyの長さは0文字以上50文字以下
  validates :name, length: { in: 1..20 }
  validates :body, length: { in: 0..20 }

  mount_uploader :image, ImageUploader

  belongs_to :user

  def self.all_posts
    Post.all.order(created_at: :desc)
  end
end
