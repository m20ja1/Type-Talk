Rails.application.routes.draw do

  # 認証（自動生成）
  resource :session
  resources :passwords, param: :token

  # 新規登録
  resources :users, only: [ :new, :create ], path_names: { new: "sign_up" }

  # トップページ
  root "homes#top"

  # ユーザー(マイページ)
  resources :users, only: [ :index, :show, :edit, :update, :destroy ]

  # 投稿機能
  resources :posts

  #検索機能
  get "search" => "searches#search"

  #コメント機能
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
