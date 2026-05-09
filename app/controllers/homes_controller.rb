class HomesController < ApplicationController
  #ログイン無しでアクセスを許可
  allow_unauthenticated_access only: :top

  def top
    @posts = Post.all.order(created_at: :desc).limit(4)
    
  end
end
