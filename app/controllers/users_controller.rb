class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "タスク「#{@user.user}」を作成しました"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "タスク「#{@user.user}」を更新しました"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @task.destroy
    redirect_to users_path
    flash[:notice] = "タスク「#{@task.name}」を更新しました"
  end

  private

  def user_params
    params.require(:user).permit(:user, :email, :password, :password_confirmation)
  end
end
