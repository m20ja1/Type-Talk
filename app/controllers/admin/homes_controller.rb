class Admin::HomesController < Admin::ApplicationController
  def top
    @users_count = User.count
    @posts_cout = Post.count
  end
end
