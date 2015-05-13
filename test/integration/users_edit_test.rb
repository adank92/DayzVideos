require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:bob)
  end

  test "update profile should fail if wrong information is submited" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                    email: 'a.com',
                                    password: 'asd',
                                    password_confirmation: 'asdf' }
    assert_template 'users/edit'
  end

  test "successful edit with friendly redirect" do
    log_in_as(@user)
    name = 'New Name'
    email = 'new@email.com'
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: 'password',
                                    password_confirmation: 'password' }
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
