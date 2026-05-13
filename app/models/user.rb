class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships,  class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  # バリデーション
  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

    # 検索機能
    def self.looks(search, word)
      if search == "perfect_match"
        where("name = ? OR mbti_type = ?", word, word)
      elsif search == "forward_match"
        where("name LIKE ? OR mbti_type LIKE ?", "#{word}%", "#{word}%")
      elsif search == "backward_match"
          where("name LIKE ? OR mbti_type LIKE ?", "%#{word}", "%#{word}")
      elsif search == "partial_match"
          where("name LIKE ? OR mbti_type LIKE ?", "%#{word}%", "%#{word}%")
      else
          all
      end
    end
end
