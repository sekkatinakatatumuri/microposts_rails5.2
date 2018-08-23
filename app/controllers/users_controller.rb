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
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      ## ここ
      flash[:success] = 'ユーザを登録しました。'
      # 処理を users#show のアクションへと強制的に移動
      redirect_to @user
    else
      ## ここ
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      # 単に users/new.html.erb を表示
      render :new
    end
  end

  private

  def user_params
    # password から暗号化され password_digest として保存
    # password_confirmation は password の確認のために使用
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
