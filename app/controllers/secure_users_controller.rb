class SecureUsersController < ActionController::API
  include Secured

  def me
    render json: current_user
  end
end
