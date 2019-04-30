class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :correct_user, only: %i[show]

  def show
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
      flash[:notice] = "ユーザー「#{@user.user}」の新規登録に成功しました"
      redirect_to tasks_path
    else
      flash.now[:danger] = 'ユーザーの新規登録に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user, :email, :admin, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
