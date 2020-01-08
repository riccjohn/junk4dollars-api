class AddRelationsAndBids < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth0_id, :string, unique: true, null: false
    add_reference :auctions, :user, null: false, foreign_key: true
    create_table :bids do |t|
      t.integer :price
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true
    end
  end
end
