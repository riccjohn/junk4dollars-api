require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get /users/1 endpoint' do
    new_user = User.create(name: 'Test')
    get "/users/#{new_user['id']}"
    assert_response :success
  end

  test '/users/1 should retrieve a single user' do
    user_name = 'Maggie'
    new_user = User.create(name: user_name)
    puts new_user.foo.inspect
    get "/users/#{new_user.id}"

    user_response = JSON.parse(@response.body, symbolize_names: true)
    assert_equal user_name, user_response[:name]
  end

  test 'should get /users endpoint' do
    get '/users'
    assert_response :success
  end

  test '/users should retrieve all users as json' do
    users = ['John', 'Polly']
    users.each { |user| User.create(name: user)}

    get '/users'

    users_response = JSON.parse(@response.body, symbolize_names: true)
    response_names = users_response.map {|user| user[:name]}

    assert_equal response_names, users
    assert_equal 2, users_response.count
  end
end
