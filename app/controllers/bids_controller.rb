class BidsController < ApplicationController
  include Secured

  def create
    auction_id = params[:auction_id]
    price = params['bid']['price']

    bid = Bid.create!(auction_id: auction_id, user: current_user, price: price)
    render json: bid
  end
end
