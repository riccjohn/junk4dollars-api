class ApplicationController < ActionController::API
  def dummy_api
    render json: {
      foo: "bar"
    }.to_json
  end
end
