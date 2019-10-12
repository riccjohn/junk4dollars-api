class ApplicationController < ActionController::API
  def dummy_api
    render json: {
      foo: 'bar'
    }
  end
end
