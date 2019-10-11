require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get /dummy endpoint' do
    get '/dummy'
    assert_response :success
  end

  test '/dummy endpoint should respond with 200' do
    get '/dummy'
    assert_equal 200, response.code.to_i
  end

  test '/dummy endpoint should respond with json data' do
    get '/dummy'
    dummy_response = JSON.parse(@response.body)
    assert_equal 'bar', dummy_response['foo']
  end
end
