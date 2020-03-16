class SessionsController < ApplicationController

  def new
  end

  def create # sessionにはモデルがない為下記のような記載になる？ 6.2.2
    
    # ↓Userテーブルからemailで該当するレコードを取得
    user = User.find_by(email: params[:session][:email].downcase)
    
    # ↓取得したレコードのパスワードと、入力されたパスワードが一致するか検証
    # ⇒authenticate ⇒ 4.5．6章参考
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザー情報ページにリダイレクトします。
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
end
