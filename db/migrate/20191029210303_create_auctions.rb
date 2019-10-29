class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :description
      t.decimal :start_bid, precision: 10, scale: 2
      t.decimal :current_bid, precision: 10, scale: 2
      t.binary :image
      t.datetime :end_time

      t.timestamps
    end
  end
end
