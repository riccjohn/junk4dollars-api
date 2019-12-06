class User < ApplicationRecord
  def self.get_user_by_auth0_id(id)
    User.find_by_auth0_id!(id)
  end
end
