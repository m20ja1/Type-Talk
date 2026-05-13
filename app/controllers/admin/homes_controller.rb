class Admin::HomesController < Admin::ApplicationController
  def top
    @users_count = User.count
    @posts_count = Post.count
  end
end
