class SessionsController < ApplicationController
  def new
    # Model が無いので、コードの追加は無し
  end

  def create
    # フォームデータのemailを小文字化して取得
    email = params[:session][:email].downcase
    # フォームデータのpasswordを取得
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      # 処理を users#show のアクションへと強制的に移動させる
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      # sessions/new.html.erbを表示
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    # トップページにリダイレクト
    redirect_to root_url
  end
  
  private

  def login(email, password)
    # メールでユーザを取得
    @user = User.find_by(email: email)
    # ユーザが取得できていてかつログイン認証が成功した場合
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
