class User < ApplicationRecord
  has_many :auctions
  def self.get_user_by_auth0_id(id)
    User.find_by_auth0_id!(id)
  end
end
