class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      # Micropost を投稿するフォームを設置するので、@micropost にカラのインスタンスを代入
      @micropost = current_user.microposts.build
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
    end
  end
end
