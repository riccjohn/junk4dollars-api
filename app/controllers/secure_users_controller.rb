class SecureUsersController < ActionController::API
  include Secured

  def me
    render json: user
  end
end
