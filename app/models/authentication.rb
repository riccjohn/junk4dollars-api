class Authentication

  def initialize(parser)
    @parser = parser
  end

  def current_user(request)
    # authorization: 'bearer token'
    if request.headers['bearer']
      bearer = request.headers['bearer']
      begin
        user_to_retrieve = @parser.auth0_id(bearer)
        User.find_by_auth0_id(user_to_retrieve)
      rescue => exception
        print exception
        return nil
      end
    end
  end
end
