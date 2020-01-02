class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.integer :price
      t.timestamps
    end

    add_reference :bids, :user, null: false, foreign_key: true
    add_reference :bids, :auction, null: false, foreign_key: true
  end
end
