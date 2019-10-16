require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'all_user_public_data method returns specific values' do
    new_users = ['UserOne', 'UserTwo']
    new_users.each { |user| User.create(name: user)}
    user_data = User.all_user_public_data
    assert_equal user_data[0].attributes.keys, %w(id name created_at updated_at)
  end

  test 'single_user_public_data returns specific values' do
    new_user = User.create(name: 'NewUser')
    user_data = User.single_user_public_data(new_user[:id])
    assert_equal user_data.attributes.keys, %w(id name created_at updated_at)
  end
end
