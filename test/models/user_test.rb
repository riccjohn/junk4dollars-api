require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'get_user_by_auth0_id returns a user' do
    user = User.create(id: 1, name: 'Robert California', auth0_id: 100)
    returned_user = User.get_user_by_auth0_id(user.auth0_id)
    assert_equal user.name, returned_user.name
  end

  test 'get_user_by_auth0_id will deal with not finding a user' do
    assert_raises(ActiveRecord::RecordNotFound) do
      User.get_user_by_auth0_id(123)
    end
  end
end
