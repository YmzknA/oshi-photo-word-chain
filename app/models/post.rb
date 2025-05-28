class Post < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true

  validates :name, length: { in: 2..20 }
  validates :body, length: { in: 0..200 }
  validates :url, length: { in: 0..2083 }
  validate :url_format_validation, if: -> { url.present? }

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy

  def self.all_posts
    Post.all.order(created_at: :desc)
  end

  private

  def url_format_validation
    return if url.blank?

    uri = URI.parse(url)
    errors.add(:url, 'is not a valid URL') unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:url, 'is not in the correct format')
  end
end
