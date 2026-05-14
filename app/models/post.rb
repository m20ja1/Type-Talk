class Post < ApplicationRecord

  attr_accessor :tag_list

  belongs_to :user
  # ジャンル追加したら「oputional:true」を削除
  belongs_to :genre, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorite

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
    
    #いいね機能
    def favorited_by?(user)
      return false if user.nil?
      favorites.exists?(user_id: user.id)
    end

    #タグ検索
    def save_tags(tag_names)
      return if tag_names.nil?

      tag_list = tag_names.split(',').map(&:strip).uniq
      self.tags.clear
      tag_list.each do |name|
        tag = Tag.find_or_create_by(name: name)
        self.tags << tag
      end
    end

end
