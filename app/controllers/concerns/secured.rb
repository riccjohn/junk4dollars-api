module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  def authenticate_request!
    @user = System.authentication.current_user(request)
    unless @user
      render status: 401
    end
    #   auth_token
    # rescue JWT::VerificationError, JWT::DecodeError
    #   render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def user
    @user
  end
  # def http_token
  #   if request.headers['Authorization'].present?
  #     request.headers['Authorization'].split(' ').last
  #   end
  # end

  # def auth_token
  #   JsonWebToken.verify(http_token)
  # end

  # def auth0_id
  #   auth_token.first['sub']
  # end
end