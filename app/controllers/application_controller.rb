class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin_true?
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def logged_in?
    current_user.present?
  end

  def admin_true?
    current_user.admin == true
  end
end
