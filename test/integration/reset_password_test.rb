require 'test_helper'

class ResetPasswordTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    ActionMailer::Base.deliveries.clear
  end

  test "password reset" do
    get new_password_reset_url
    assert_template 'password_resets/new'
    # invalid email
    post password_resets_path, password_reset: { email: '' }
    assert_not flash[:danger].empty?
    assert_template 'password_resets/new'
    # valid email
    post password_resets_path, password_reset: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_redirected_to root_path
    assert_not flash[:info].empty?
    assert_equal 1, ActionMailer::Base.deliveries.size
    # take user from controller
    user = assigns(:user)
    # invalid token
    get edit_password_reset_path(User.new_token, email: user.email)
    assert_not flash[:danger].empty?
    assert_redirected_to root_path
    # not activated
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_not flash[:danger].empty?
    assert_redirected_to root_path
    user.toggle!(:activated)
    # invalid email
    get edit_password_reset_path(user.reset_token, email: '')
    assert_not flash[:danger].empty?
    assert_redirected_to root_path
    # valid token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select 'input[name=email][type=hidden][value=?]', user.email
    # invalid password
    patch password_reset_url(user.reset_token, email: user.email, user: { password: '',
                                                                          password_confirmation: '' })
    assert_select 'div#error_explanation'
    assert_not is_logged_in?
    # valid password
    patch password_reset_url(user.reset_token, email: user.email, user: { password: 'password',
                                                                          password_confirmation: 'password' })
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
    assert user.reload.authenticate('password')
  end

  test "expiration token" do
    post password_resets_path, password_reset: { email: @user.email }
    user = assigns(:user)
    user.update_attribute(:reset_sent_at, 3.days.ago)
    patch password_reset_path(user.reset_token, email: user.email, user: { password: 'password',
                                                                           password_confirmation: 'password' })
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end
end
