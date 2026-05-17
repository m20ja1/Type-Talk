class NotificationsController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = current_user.notifications.includes(:notifiable).order(created_at: :desc).to_a.compact_blank
    @notifications.each { |n| n.update(read: true) if n.read == false }
  end

  def update
    notfication = current_user.notifications.find(params[:id])
    notfication.update(read: true)
    case notification.notfiable_type
    when "Post"
      redirect_to post_path(notification.notifiable)
    else
      redirect_to user_path(notification.notifiable.user)
    end
  end
end
