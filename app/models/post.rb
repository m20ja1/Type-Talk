class Post < ApplicationRecord
  belongs_to :user
  #ジャンル追加したら「oputional:true」を削除
  belongs_to :genre, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
end
