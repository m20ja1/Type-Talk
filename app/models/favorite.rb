class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  after_create do
    create_notification(user_id: post.user_id)
  end

  private

  def create_notification(user_id:)
    Notification.create!(
      user_id: user_id,
      notifiable: self
    )
  end

end
