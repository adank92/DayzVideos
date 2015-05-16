require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:bob)
    @other_user = users(:john)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when wrong user" do
    log_in_as @user
    get :edit, id: @other_user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when wrong user" do
    log_in_as @user
    patch :update, id: @other_user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if not admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should not allow to update admin boolean" do
    log_in_as @other_user
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { name: 'Updated name',
                                            email: 'updated@email.com',
                                            password: 'password',
                                            password_confirmation: 'password',
                                            admin: true }
    assert_not @other_user.admin?
  end

  test "should redirect new when logged in" do
    log_in_as @user
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end
