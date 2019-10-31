class Auction < ApplicationRecord
  def self.all_auctions
    all
  end

  def self.single_auction(id)
    find(id)
  end
end
