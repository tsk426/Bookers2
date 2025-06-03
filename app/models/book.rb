class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  
  def self.search_for(content, method)
    case method
    when 'perfect'
      where("title = ? OR body = ?", content, content)
    when 'forward'
      where("title LIKE ? OR body LIKE ?", "#{content}%", "#{content}%")
    when 'backward'
      where("title LIKE ? OR body LIKE ?", "%#{content}", "%#{content}")
    when 'partial'
      where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
    else
      all
    end
  end


end
