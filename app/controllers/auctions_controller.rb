class AuctionsController < ApplicationController
  def index
    auctions = Auction.all
    render json: auctions
  end

  def show
    auction = Auction.find(params[:id])
    render json: auction
  end
end
