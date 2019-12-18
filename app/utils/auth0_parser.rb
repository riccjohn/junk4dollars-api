class Auth0Parser
  def self.authenticate_request(request)
    auth_token(request)
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def self.http_token(request)
    request.headers['Authorization'].split(' ').last
  end

  def self.auth_token(request)
    JsonWebToken.verify(http_token(request))
  end

  def self.auth0_id(request)
    authenticate_request(request)
    auth_token(request).first['sub']
  end
end
