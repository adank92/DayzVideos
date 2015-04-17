require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'invalid login' do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'foo@bar', password: 'foobar' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'successful login followed by a logout' do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', user_path(@user), count: 0
    assert_select 'a[href=?]', logout_path, count: 0
  end
end
