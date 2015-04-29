class PasswordResetsController < ApplicationController
  before_action :validate_token, only: [:edit, :update]

  def new
  end

  def create
    if user = User.find_by_email(params[:password_reset][:email])
      user.create_reset_token
      user.send_reset_password_email
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
  end

  private

    def validate_token
      @user = User.find_by_email(params[:email])
      unless @user && @user.authenticated?(:reset, params[:id])
        flash[:danger] = 'Invalid reset link'
        redirect_to root_path
      end
    end
end
