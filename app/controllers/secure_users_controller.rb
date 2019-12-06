class SecureUsersController < ActionController::API
  include Secured

  def me
    user = User.get_user_by_auth0_id(auth0_id)
    render json: user
  end
end
