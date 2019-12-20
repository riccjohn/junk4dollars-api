require 'test_helper'

class SecureUsersControllerTest < ActionDispatch::IntegrationTest
  test '/user/me should return a user if properly authenticated' do
    System.authentication = FakeAuthentication.new
    authentication = System.authentication

    user = User.create(id: 1, name: 'foo', auth0_id: 123)
    authentication.current_user = user

    get '/user/me'
    user_response = JSON.parse(@response.body)
    assert_response :success
    assert_equal user.name, user_response['name']
  end

  test '/user/me should return a 401 if unauthorized' do
    System.authentication = FakeAuthentication.new
    get '/user/me'
    assert_response 401
  end
end
