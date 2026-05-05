Rails.application.routes.draw do
  get "posts/index"
  get "posts/new"
  get "posts/create"
  get "posts/show"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  get "users/index"
  get "users/new"
  get "users/create"
  get "users/show"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  get "homes/top"
  # 認証（自動生成）
  resource :session
  resources :passwords, param: :token

  # トップページ
  root "homes#top"

  # 新規登録
  get  "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"

  # ユーザー(マイページ)
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  # 投稿機能
  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check
end