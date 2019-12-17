class Auth0Parser
  def authenticate_request(request)
    @request = request
    auth_token
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    if @request.headers['Authorization'].present?
      @request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end

  def auth0_id
    auth_token.first['sub']
  end
end
