desc 'Delete auctions with no bids that are older than 1 week'
task delete_old_auctions: :environment do
  sql = '
  DELETE
  FROM auctions
    WHERE id NOT IN ( SELECT auction_id FROM bids )
      AND Date(auctions.created_at) < CURRENT_DATE - 7;
  '

  result = ActiveRecord::Base.connection.delete(sql)
  p result
end
