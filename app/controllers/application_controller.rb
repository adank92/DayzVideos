class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in'
      redirect_to login_path
    end
  end

  def not_logged_in_user
    if logged_in?
      flash[:danger] = 'Already logged in'
      redirect_to root_path
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
