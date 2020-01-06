class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids

  def bid
    bids.order(:created_at).last
  end
end
