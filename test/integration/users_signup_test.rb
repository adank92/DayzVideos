require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "invalid@email",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_select 'div#error_explanation'
    assert_select 'div#error_explanation li'
    assert_template :new
  end

  test "valid signup information and account activation" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "test",
                               email: "test@domain.com",
                               password: "password",
                               password: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # login without activating account
    log_in_as user
    assert_not flash[:info].empty?
    assert_redirected_to root_path
    assert_not is_logged_in?
    # invalid activate token
    get edit_account_activation_url('invalid id')
    assert_not is_logged_in?
    # invalid email
    get edit_account_activation_url(user.activation_token, email: "wrong@email.com")
    assert_not is_logged_in?
    # valid token and email
    get edit_account_activation_url(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
