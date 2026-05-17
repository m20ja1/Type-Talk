class NotificationsController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.where(read: false).update_all(read: true)
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
