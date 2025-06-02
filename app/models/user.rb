class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローしている関係
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  # フォローされている関係
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def resized_variant
    file.variant(resize: "300x300").processed
  end

   # フォローする
   def follow(other_user)
    following << other_user unless self == other_user
  end

  # フォロー解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # フォローしているか確認
  def following?(other_user)
    following.include?(other_user)
  end
end
