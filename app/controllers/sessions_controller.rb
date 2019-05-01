class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'ログインに成功しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
