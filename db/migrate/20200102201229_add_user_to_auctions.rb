class AddUserToAuctions < ActiveRecord::Migration[6.0]
  def change
    add_reference :auctions, :user, null: false, foreign_key: true
  end
end
