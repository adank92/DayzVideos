require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "invalid@email",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template :new
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count' do
      post_via_redirect users_path, user: { name: "test",
                               email: "test@domain.com",
                               password: "testtest",
                               password: "testtest" }
    end
    assert_template :show
  end
end
