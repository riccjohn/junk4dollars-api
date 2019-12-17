class Authentication

  def initialize(parser)
    @parser = parser
  end

  def current_user(request)
    if request.headers['authorization']
      bearer = get_bearer_token(request.headers)
      begin
        user_to_retrieve = @parser.auth0_id(bearer)
        User.find_by_auth0_id(user_to_retrieve)
      rescue => exception
        print exception
        return nil
      end
    end
  end

  private

  def get_bearer_token(header)
    auth = header['authorization']
    auth_array = auth.split(' ')
    bearer_index = auth_array.index('bearer')
    auth_array[bearer_index + 1]
  end
end
