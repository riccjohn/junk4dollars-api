class MakeUserIdNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :auctions, :user_id, true
  end
end
