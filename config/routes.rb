Rails.application.routes.draw do
  # 認証（自動生成）
  resource :session
  resources :passwords, param: :token

  # 新規登録
  resources :users, only: [ :new, :create ], path_names: { new: "sign_up" }

  # トップページ
  root "homes#top"

  # ユーザー(マイページ)
  resources :users, only: [ :index, :show, :edit, :update, :destroy ] do
    member do
      get :favorites
    end
  end


  # 投稿機能
  resources :posts

  # 検索機能
  get "search" => "searches#search"

  # コメント機能・いいね機能
  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resource :favorites, only: [:create, :destroy]
  end

  # 管理者用
  namespace :admin do
    get "posts/index"
    get "users/index"
    get "homes/top"
    resource :session, only: [ :new, :create, :destroy ]

    # URL:/admin
    get "top" => "homes#top", as: :top
    root "homes#top"

    resources :users, only: [ :index, :show, :destroy ]
    resources :posts, only: [ :index, :destroy ]
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
