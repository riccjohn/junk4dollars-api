require 'test_helper'

class SecureUsersControllerTest < ActionDispatch::IntegrationTest
  test '/user/me should return a user if properly authenticated' do
    System.authentication = Authentication.new
    authentication = System.authentication

    user = User.create(id: 1, name: 'foo', auth0_id: 123)
    authentication.current_user = user

    get '/user/me'
    user_response = JSON.parse(@response.body)
    assert_response :success
    assert_equal user.name, user_response['name']
  end

  test '/user/me should return a 401 if unauthorized' do
    System.authentication = Authentication.new
    get '/user/me'
    assert_response 401
  end

  test 'if /user/me receives a header, it should return a user that matches the id on the header' do
    System.authentication = Authentication.new
    user = User.create(id: 2, name: 'bar', auth0_id: 'auth0|5ddc4e5801825f0f008cf4c5')
    request.headers['Bearer'] = '' # ???
    get '/user/me'
    assert_response :success
    assert_equal user.name, user_response['name']
  end
end
