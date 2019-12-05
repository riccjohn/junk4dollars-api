class SecureUsersController < ActionController::API
  include Secured

  def me
    token = request.headers['Authorization'].split(' ').last
    pp(token)
    render json: {id: 1, name: 'John Riccardi', email: 'john@8thlight.com'}
  end
end
