class Auth0Parser
  def self.auth_token(token)
    JsonWebToken.verify(token)
  end

  def self.auth0_id(token)
    auth_token(token).first['sub']
  end
end
