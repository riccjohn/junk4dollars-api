class User < ApplicationRecord
  has_secure_password

  def self.all_user_public_data
    all
  end

  def self.single_user_public_data(id)
    find(id)
  end
end
