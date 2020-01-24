desc 'Delete auctions with no bids that are older than 1 week'
task :delete_old_auctions do
  @connection = ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    database: 'junk4dollars_development'
  )

  sql = '
  DELETE
  FROM auctions
    WHERE id NOT IN ( SELECT auction_id FROM bids )
      AND Date(auctions.created_at) < CURRENT_DATE - 7;
  '

  result = ActiveRecord::Base.connection.delete(sql)
  p result
end
