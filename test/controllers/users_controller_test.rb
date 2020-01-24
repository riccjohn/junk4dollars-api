require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get /users/1 endpoint' do
    new_user = User.create(name: 'Test', auth0_id: 'foo')
    get "/users/#{new_user['id']}"
    assert_response :success
  end

  test '/users/1 should retrieve a single user' do
    user_name = 'Maggie'
    new_user = User.create(name: user_name, auth0_id: 'foo')
    get "/users/#{new_user.id}"

    user_response = JSON.parse(@response.body, symbolize_names: true)
    assert_equal user_name, user_response[:name]
  end

  test 'should get /users endpoint' do
    get '/users'
    assert_response :success
  end

  test '/users should retrieve all users as json' do

    users = [
      {name: 'John', auth0_id: '001'},
      {name: 'Polly', auth0_id: '002'}
    ]

    users.each { |user| User.create(user)}

    get '/users'

    users_response = JSON.parse(@response.body, symbolize_names: true)
    response_names = users_response.map {|user| user[:name]}

    assert_equal response_names, users.map {|user| user[:name]}
    assert_equal 2, users_response.count
  end

  test '/users/top/:count should retrieve the top users by number of bids' do

    users_to_create = [
      {name: 'John', auth0_id: '001'},
      {name: 'Polly', auth0_id: '002'},
      {name: 'Quinn', auth0_id: '003'},
      {name: 'Ignacio', auth0_id: '004'},
      {name: 'Eric', auth0_id: '005'}
    ]

    created_users = users_to_create.map { |user| User.create(user)}

    auction_to_create = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: created_users[4].id
    }

    auction = Auction.create!(auction_to_create)

    create_bid(user_id: created_users[0].id, auction_id: auction.id) # John     (1)
    create_bid(user_id: created_users[1].id, auction_id: auction.id) # Polly    (1)
    create_bid(user_id: created_users[0].id, auction_id: auction.id) # John     (2)
    create_bid(user_id: created_users[2].id, auction_id: auction.id) # Quinn    (1)
    create_bid(user_id: created_users[0].id, auction_id: auction.id) # John     (3)
    create_bid(user_id: created_users[3].id, auction_id: auction.id) # Ignacio  (1)
    create_bid(user_id: created_users[2].id, auction_id: auction.id) # Quinn    (2)
    create_bid(user_id: created_users[3].id, auction_id: auction.id) # Ignacio  (2)
    create_bid(user_id: created_users[0].id, auction_id: auction.id) # John     (4)
    create_bid(user_id: created_users[3].id, auction_id: auction.id) # Ignacio  (3)

    get '/users/top/2'
    top_users = JSON.parse(@response.body, symbolize_names: true)

    assert_equal 2, top_users.count
    john = top_users.select {|u| u[:name] == 'John'}.first
    ignacio = top_users.select {|u| u[:name] == 'Ignacio'}.first

    assert_equal 4, john[:count]
    assert_equal 3, ignacio[:count]
  end
end
