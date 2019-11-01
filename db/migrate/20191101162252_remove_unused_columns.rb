class RemoveUnusedColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :auctions, :image
  end
end
