Rails.application.routes.draw do
  # 認証（自動生成）
  resource :session
  resources :passwords, param: :token

  # 新規登録
  resources :users, only: [:new, :create] , path_names: { new: 'sign_up' }

    # トップページ
  root "homes#top"

  # ユーザー(マイページ)
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  # 投稿機能
  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check
end