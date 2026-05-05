class HomesController < ApplicationController
  #ログイン無しでアクセスを許可
  allow_unauthenticated_access only: :top

  def top
  end
end
