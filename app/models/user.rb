class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
   validates :name
  end

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
