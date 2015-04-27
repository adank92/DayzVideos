require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:one)
    @non_admin = users(:two)
  end

  test 'index including pagination' do
    log_in_as(@admin)
    get users_path
    assert 'users/index'
    assert_select 'ul.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete', method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete @non_admin
    end
  end
end