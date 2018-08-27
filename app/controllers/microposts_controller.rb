class MicropostsController < ApplicationController
  # ログインが必須
  before_action :require_user_logged_in
  
  def create
    # ログインユーザのマイクロポストを作成
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    # redirect_back は、アクションが実行されたページに戻る
    # fallback_location: root_path は、戻るべきページがない場合には root_path に戻る
    redirect_back(fallback_location: root_path)
  end
  
  private

  # ストロングパラメーター
  def micropost_params
    params.require(:micropost).permit(:content)
  end


  def correct_user
    # ログインユーザのマイクロポストかを確認
    @micropost = current_user.microposts.find_by(id: params[:id])
    # 違う場合
    unless @micropost
      redirect_to root_url
    end
  end
end
