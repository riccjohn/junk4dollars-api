class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.integer :price
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true
    end
  end
end
