class Admin::UsersController < Admin::ApplicationController
  def index
    @user = User.order(created_at: :desc)
    @users =User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを退会処理しました"
  end
end
