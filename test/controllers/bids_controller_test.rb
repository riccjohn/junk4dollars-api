require 'test_helper'

class BidsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(name: 'John', auth0_id: 'auth0|0001')
    @auction = Auction.create!(
      title: 'Fallen Empires Booster',
      description: '3x MTG Fallen Empires booster packs',
      starting_price: 1_000,
      ends_at: 10.days.from_now,
      user_id: @user.id
    )
  end

  test 'should deny access if not authenticated' do
    System.authentication = FakeAuthentication.new
    post "/bid/#{@auction.id}"
    assert_response 401
  end

  test 'should create a new bid if auction exists' do
    System.authentication = FakeAuthentication.new
    authentication = System.authentication
    authentication.current_user = @user

    new_bid_price = 1_299

    post "/bid/#{@auction.id}", as: :json, params: { price: new_bid_price }

    response = JSON.parse(@response.body, symbolize_names: true)

    assert_response :success
    assert_equal new_bid_price, response[:price]
  end
end
