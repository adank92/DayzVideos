require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:bob)
    @non_admin = users(:john)
  end

  test 'index including pagination' do
    log_in_as(@admin)
    get users_path
    assert 'users/index'
    assert_select 'ul.pagination', count: 2
    User.paginate(page: 1, per_page: 10).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete', method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
end
