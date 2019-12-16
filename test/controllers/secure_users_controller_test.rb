require 'test_helper'

class SecureUsersControllerTest < ActionDispatch::IntegrationTest
  test '/user/me should return 401 if not given a valid token' do
    get '/user/me'
    assert_response 401
  end

  # test '#me should return a user if properly authenticated' do
  #   user = User.create(id: 1, name: "foo", auth0_id: 123)
  #   Services[:secured_concern] = FakeSecuredConcern
  #   get '/user/me'
  #   user_response = JSON.parse(@response.body)
  #   assert_success
  #   assert_equal user.name, user_response.name
  # end

  # test '/user/me should return a 401 if given an invalid token' do

  # end

  # test '/user/me/ should raise an exception if given a valid token with an auth0 id that is not on the database'

  # end
end
