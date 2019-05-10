class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[show edit update index]

  def index
    @users = User.recent.page(params[:page]).includes(:tasks)
  end

  def show
    @tasks = @user.tasks.recent.page(params[:page])
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "タスク「#{@user.user}」を作成しました"
      redirect_to admin_users_path
    else
      flash[:notice] = "ユーザー「#{@user.user}」の作成に失敗しました"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー「#{@user.user}」を更新しました"
      redirect_to admin_users_path
    elsif @user.admin == false && User.where(admin:true).count == 1 && @user == User.find_by(admin: true)
      flash[:notice] = "管理者が1人であるため管理者権限を外すことに失敗しました"
      render 'edit'
    else
      flash[:notice] = "ユーザー「#{@user.user}」の更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
      flash[:notice] = "ユーザー「#{@user.user}」を削除しました"
    else
      redirect_to admin_users_path
      flash[:notice] = "管理者が1人であるため削除に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:user, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
