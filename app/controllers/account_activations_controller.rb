class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by_email(params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Welcome aboard fellow survivor!"
      redirect_to user
    else
      flash[:warning] = "Invalid activation link"
      redirect_to root_path
    end
  end
end
