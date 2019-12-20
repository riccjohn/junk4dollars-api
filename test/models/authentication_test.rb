require 'minitest/mock'
require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  def setup
    @parser = double(authenticate_request: true, auth0_id: 'auth0|002')
    @authentication = Authentication.new(@parser)
  end

  test 'when request not authenticated, current_user returns nil' do
    request = double(headers: {})
    returned_user = @authentication.current_user(request)
    assert_nil returned_user
  end

  test 'when request includes a bearer token with an unknown auth0_id, current_user returns nil' do
    request = double(headers: {'Authorization' => 'bearer foo'})
    User.create(id: 1, name: 'foo', auth0_id: 'auth0|001')
    returned_user = @authentication.current_user(request)
    assert_nil returned_user
  end

  test 'when request includes a valid bearer token, current_user returns matching user' do
    request = double(headers: {'Authorization' => 'bearer foo'})
    User.create(id: 1, name: 'foo', auth0_id: 'auth0|001')
    user = User.create(id: 2, name: 'bar', auth0_id: 'auth0|002')
    returned_user = @authentication.current_user(request)
    assert_equal user, returned_user
  end

  test 'when request includes an invalid bearer token, current_user returns nil' do
    request = double(headers: {'Authorization' => 'bearer bar'})
    allow(@parser).to receive(:auth0_id).with('bar') {raise 'Invalid bearer'}
    User.create(id: 1, name: 'foo', auth0_id: 'auth0|001')
    returned_user = @authentication.current_user(request)
    assert_nil returned_user
  end
end
