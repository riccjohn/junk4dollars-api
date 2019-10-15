class User < ApplicationRecord
  def self.all_user_public_data
    all.select(:id, :name, :created_at, :updated_at)
  end

  def self.single_user_public_data(id)
    select(:id, :name, :created_at, :updated_at).find(id)
  end
end
