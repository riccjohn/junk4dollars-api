class AuctionOwner < ActiveRecord::Migration[6.0]
  def change
    add_reference :auctions, :user, index: true, foreign_key: true
  end
end
