class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # debugger # インスタンス変数を定義した直後にこのメソッドが実行されます。
  end
  
  def new
    @user = User.new # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    # @user = User.new(params[:user]) 5.5.2
    @user = User.new(user_params)
    if @user.save
      # lon_in(@user) ↓多分下記は省略形
      # 下記@userはsession_hepler定義の
      # log_in(user)の引数(user)に@userを渡してる
      log_in @user # 新規作成後、ログイン 6.5
      
      flash[:success] = '新規作成に成功しました。'
      # redirect_to user_url(@user) ↓ 5.5.5
      redirect_to @user
    else
      render :new
    end
  end
  
  private

    def user_params # 5.5.3
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
