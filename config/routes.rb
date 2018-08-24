Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # resources :sessions, only: [:new, :create, :destroy] 
  # 上記としても良いですが、これも URL の見栄えを考慮して、個別にルーティングを設定

  # ユーザの新規登録URLを/users/newではなく、/signupにするためのルーティング
  get 'signup', to: 'users#new'
  # index, show, new, create のみを実装し、edit, update, destroy は実装しない
  # つまりユーザ登録(newはsignupにしている)、一覧表示、詳細表示は可能でも、
  # ユーザ情報の編集（名前やメール、パスワードの変更など）、ユーザの削除（退会）は不可
  resources :users, only: [:index, :show, :create]
  
  # マイクロポストは作成と削除だけ実装
  resources :microposts, only: [:create, :destroy]
end