Rails.application.routes.draw do
  root to: 'toppages#index'

  # ユーザの新規登録URLを/users/newではなく、/signupにするためのルーティング。
  get 'signup', to: 'users#new'
  # index, show, new, create のみを実装し、edit, update, destroy は実装しません。
  # つまりユーザ登録(newいらなければ消せる)、一覧表示、詳細表示は可能でも、
  # ユーザ情報の編集（名前やメール、パスワードの変更など）、ユーザの削除（退会）は不可
  resources :users, only: [:index, :show, :new, :create]
end