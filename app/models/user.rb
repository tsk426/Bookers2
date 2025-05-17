class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  # ログインに必要な情報メアド⇒nameのバリデーション
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
