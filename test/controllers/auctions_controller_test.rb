require 'test_helper'
require 'date'

class AuctionsControllerTest < ActionDispatch::IntegrationTest
  test '/auctions should retrieve all auctions as json' do

    user = User.create(name: 'Foo', auth0_id: 'bar')

    auctions_to_create = [
      {
        title: 'Mustang',
        description: '1968 Ford Mustang',
        starting_price: 1_200_000,
        ends_at: 10.days.from_now,
        user_id: user.id
      },
      {
        title: 'Fallen Empires Booster',
        description: '3x MTG Fallen Empires booster packs',
        starting_price: 1_000,
        ends_at: 10.days.from_now,
        user_id: user.id
      }
    ]

    auctions_to_create.each { |auction| Auction.create(auction) }

    get '/auctions'
    auction_response = JSON.parse(@response.body, symbolize_names: true)
    response_auction_titles = auction_response.map {|auction| auction[:title]}

    assert_response :success
    assert_equal auctions_to_create.count, auction_response.count
    assert_equal auctions_to_create.map {|auction| auction[:title]}.sort, response_auction_titles.sort
  end

  test 'should return the correct auction given an id' do
    user = User.create(name: 'Foo', auth0_id: 'bar')

    auction_to_create = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: user.id
    }

    created_auction = Auction.create!(auction_to_create)

    get "/auctions/#{created_auction.id}"
    api_response = JSON.parse(@response.body, symbolize_names: true)

    assert_response :success
    auction_to_create.keys.each do |key|
      if (key == :ends_at)
        assert_equal standardize_time(auction_to_create[key]), standardize_time(api_response[key])
      else
        assert_equal auction_to_create[key], api_response[key]
      end
    end
  end

  test 'should return the latest bid for an auction if it has one' do
    user = User.create!(name: 'Foo', auth0_id: 'auth0|bar')

    auction = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: user.id
    }

    auction2 = {
      title: 'foo',
      description: 'bar',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: user.id
    }

    created_auction = Auction.create!(auction)
    created_auction2 = Auction.create!(auction2)

    _bid = create_bid(user_id: user.id, auction_id: created_auction.id, created_at: 1.day.ago)
    bid2 = create_bid(user_id: user.id, auction_id: created_auction.id)
    _bid3 = create_bid(user_id: user.id, auction_id: created_auction2.id)

    get "/auctions/#{created_auction.id}"
    auction_response = JSON.parse(@response.body, symbolize_names: true)
    assert_equal bid2.price, auction_response[:bid][:price]
  end

  test 'an auction with no bids should only return auction data' do
    user = User.create!(name: 'Foo', auth0_id: 'auth0|0000')

    auction_to_create = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: user.id
    }

    auction = Auction.create!(auction_to_create)

    get "/auctions/#{auction.id}"
    auction_response = JSON.parse(@response.body, symbolize_names: true)

    assert_equal auction_to_create[:title], auction_response[:title]
    assert_nil auction_response[:bid]
  end

  test '/auctions/details should return the price as the highest bid if available' do
    assert_equal 0, User.count
    assert_equal 0, Auction.count
    user = User.create!(name: 'Foo', auth0_id: 'auth0|bar')
    assert_equal 1, User.count

    auction_to_create = {
      title: 'Mustang !?!?',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ'),
      user_id: user.id
    }

    auction = Auction.create!(auction_to_create)

    assert_equal 1, Auction.count

    bid = create_bid(user_id: user.id, auction_id: auction.id)

    get '/auctions/all/details'
    auction_response = JSON.parse(@response.body, symbolize_names: true)

    assert_equal bid.price, auction_response[0][:price]
  end

  def create_bid(attributes = {})
    @price = (@price || 100) + 1
    default_attrs = {price: @price}
    Bid.create!(default_attrs.merge(attributes))
  end
end
