class BidsController < ApplicationController
  include Secured

  def create
    user_id = current_user.id
    auction_id = params[:id]
    body = JSON.parse(request.body.read, symbolize_names: true)
    price = body[:price]

    bid = Bid.create!(auction_id: auction_id, user_id: user_id, price: price)
    render json: bid
  end
end
