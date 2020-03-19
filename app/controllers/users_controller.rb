class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    # @user = User.find(params[:id])
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
  
  def edit
    # @user = User.find(params[:id])
  end
  
  # ユーザー情報更新
  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  # ユーザー基本勤怠情報更新
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  private

    def user_params # 5.5.3
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
    
    # beforeフィルター

    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location # ﾌﾚﾝﾄﾞﾘｰﾌｫﾜｰﾃﾞｨﾝｸﾞ
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      # @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user ↓へ 8.2.2
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
