class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録成功後、ログイン画面へリダイレクト
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      # エラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    terminate_session
    redirect_to sign_up_path, notice: "退会が完了しました。"
  end

  private
 
def user_params
  params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :mbti_type, :introduction)
end

end
