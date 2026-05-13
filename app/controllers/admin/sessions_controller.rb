class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :authenticate_admin!, only: %i[ new create ]

  def new
    redirect_to admin_root_path if authenticated_admin?
  end

  def create
    if admin = Admin.authenticate_by(params.permit(:email_address, :password))
      start_new_admin_session_for admin
      redirect_to admin_root_path, notice: "管理者としてログインしました"
    else
      redirect_to new_admin_session_path, alert: "メールアドレスまたはパスワードが正しくありません"
    end
  end

  def destroy
    terminate_admin_session
    redirect_to new_admin_session_path, notice: "ログアウトしました"
  end
end
