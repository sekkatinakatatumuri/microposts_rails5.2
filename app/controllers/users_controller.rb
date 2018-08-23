class UsersController < ApplicationController
  def index
    # UserモデルはRailsによって自動的にrequireされる
    # コード中に不明なクラスが登場すると特定のパスから条件に合致しそうなクラスを見つけ、
    # 自動的に読み込んでくれる
    @users = User.all.page(params[:page])
  end

  def show
  end

  def new
  end

  def create
  end
end
