class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  # def create # 6.2.2
    
  #   # ↓Userテーブルからemailで該当するレコードを取得
  #   # 入れ子になっているparameterをストロングパラメーターを使わないで取得している書き方
  #   # 小室さん勉強会参考
  #   user = User.find_by(email: params[:session][:email].downcase)
    
  #   # ↓取得したレコードのパスワードと、入力されたパスワードが一致するか検証
  #   # ⇒authenticate ⇒ 4.5．6章参考
  #   if user && user.authenticate(params[:session][:password])
      
  #     # log_in(user) ↓
  #     log_in user # ⓵ session_helper に定義しているlog_in  メソッドに user の値を渡す
      
  #     # redirect_to(user)
  #     redirect_to user
  #   else
  #     flash.now[:danger] = '認証に失敗しました。' # now ⇒ 6.2.3
  #     render :new
  #   end
  # end
  
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
