class SessionsController < ApplicationController
  before_action :not_logged_in_user, only: [:new]

  def new
    respond_to do |format|
      format.html # default
      format.js # modal
    end
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        flash[:success] = "Welcome back Survivor, have fun!"
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:danger] = "Account not activated, please check your email"
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Invalid login info, have the zombies eaten your brain?"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You are now logged out, see you in Chernarus!'
    redirect_to root_path
  end
end
