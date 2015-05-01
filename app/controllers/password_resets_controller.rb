class PasswordResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :validate_token, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    if @user = User.find_by_email(params[:password_reset][:email])
      @user.create_reset_token
      @user.send_reset_password_email
      flash[:info] = 'Email sent with instructions to reset your password.'
      redirect_to root_path
    else
      flash.now[:danger] = 'Wrong information'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'New password saved!'
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def find_user
      @user = User.find_by_email(params[:email])
    end

    def validate_token
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        flash[:danger] = 'Invalid reset link'
        redirect_to root_path
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'Password reset has expired.'
        redirect_to root_path
      end
    end
end
