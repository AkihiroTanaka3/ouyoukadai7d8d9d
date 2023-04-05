class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user
  has_many :view_counts, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # scope :スコープの名前, -> { 条件式 }でメソッド化できる
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #昨日
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end
