class Post < ApplicationRecord
  belongs_to :user
  # ジャンル追加したら「oputional:true」を削除
  belongs_to :genre, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true

  # 検索機能
    def self.looks(search, word)
      if search == "perfect_match"
        where("title = ? OR body = ?", word, word)
      elsif search == "forward_match"
        where("title LIKE ? OR body LIKE ?", "#{word}%", "#{word}%")
      elsif search == "backward_match"
        where("title LIKE ? OR body LIKE ?", "%#{word}", "%#{word}")
      elsif search == "partial_match"
        where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
      else
        all
      end
    end

end
