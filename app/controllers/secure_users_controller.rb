class SecureUsersController < ActionController::API
  include Secured

  def me
    token = request.headers['Authorization'].split(' ').last
    auth0_id = JsonWebToken.verify(token).first['sub'].split('|').last
    user = User.find_by_auth0_id(auth0_id)
    render json: user
  end
end
