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
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } #先週

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #昨日
  scope :created_2days, -> { where(created_at: 2.day.ago.all_day) } #２日前
  scope :created_3days, -> { where(created_at: 3.day.ago.all_day) } #３日前
  scope :created_4days, -> { where(created_at: 4.day.ago.all_day) } #４日前
  scope :created_5days, -> { where(created_at: 5.day.ago.all_day) } #５日前
  scope :created_6days, -> { where(created_at: 6.day.ago.all_day) } #６日前

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  # validates :star, presence: true
  # validates :star, numericality: {
  #   # only_integer: true
  #   less_than_or_equal_to:5,
  #   greater_than_or_equal_to: 1,
  # }
  
  # validates :param5, :numericality => { :less_than_or_equal_to => 5}
  # validates :param5, :numericality => { :greater_than_or_equal_to => 1}

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
