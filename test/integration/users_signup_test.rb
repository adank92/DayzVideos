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
    assert_template 'users/new'
  end
end
