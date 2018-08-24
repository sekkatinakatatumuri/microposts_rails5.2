class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # デフォルトでは Controller から Helper のメソッドを使うことは出来ない
  include SessionsHelper

  private

  # ログイン確認
  # このメソッドは全ての Controller で使用可能
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    # Micropost の数のカウント
    @count_microposts = user.microposts.count
  end
end
