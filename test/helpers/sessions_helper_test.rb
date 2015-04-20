require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
    remember(@user)
  end

  test 'current_user should return user' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current_user should return nil when digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest((User.new_token)))
    assert_nil current_user
  end

end