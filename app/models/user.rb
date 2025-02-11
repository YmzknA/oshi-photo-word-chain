class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 2, maximum: 20 }

  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def add_like(post)
    liked_posts << post
  end

  def remove_like(post)
    liked_posts.destroy(post)
  end

  def liked?(post)
    liked_posts.include?(post)
  end
end
