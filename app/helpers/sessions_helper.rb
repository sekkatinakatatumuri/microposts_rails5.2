module SessionsHelper
  # 現在ログインしているユーザを取得
  def current_user
    # ||= 左辺が未定義または偽なら右辺の値を代入
    # ログインユーザを取得
    # find_byはfindと違いエラーを発生させない
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザがログインしていればtrueを返す
  def logged_in?
    # ログインしていなければ current_user は nil を返す
    # !nil → true !true → false にするトリック
    !!current_user
  end
end