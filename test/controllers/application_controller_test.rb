require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_url
    assert_response :success
  end

  test 'home should respond with 200' do
    get root_url
    assert_equal 200, response.code.to_i
  end
end