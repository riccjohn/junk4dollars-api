class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :description
      t.integer :starting_price
      t.datetime :ends_at
      t.timestamps
    end
  end
end
