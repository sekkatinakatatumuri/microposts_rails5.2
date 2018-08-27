class UsersController < ApplicationController
  # only: で指定されたアクションに対して、事前処理を設定
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    # UserモデルはRailsによって自動的にrequireされる
    # コード中に不明なクラスが登場すると特定のパスから条件に合致しそうなクラスを見つけ、
    # 自動的に読み込んでくれる
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # flashはハッシュで出来ている、|key, value| のペアで取り出す
      # HTTP リクエストを発生させるので flash.now だと内容を保持できずに消える
      flash[:success] = 'ユーザを登録しました。'
      # 処理を users#show のアクションへと強制的に移動
      redirect_to @user
    else
      # HTTP リクエストを発生させないので flash.now が消えない
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      # 単に users/new.html.erb を表示
      render :new
    end
  end

  def followings
   @user = User.find(params[:id])
   @followings = @user.followings.page(params[:page])
   counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  private

  # Strong Parameter
  def user_params
    # params.require(:user) で User モデルのフォームから得られるデータに関するものだと明示
    #.permit(:content) で必要なカラムだけを選択
    # password から暗号化され password_digest として保存
    # password_confirmation は password の確認のために使用
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
