ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'rspec/mocks/minitest_integration'
require 'fake_authentication'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def standardize_time(string_time)
    Time.parse(string_time).strftime('%F %T')
  end

  def create_bid(attributes = {})
    @price = (@price || 100) + 1
    default_attrs = {price: @price}
    Bid.create!(default_attrs.merge(attributes))
  end
end
