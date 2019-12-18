class Authentication

  def initialize(parser)
    @parser = parser
  end

  def current_user(request)
    @request = request

    return nil unless @request.headers['Authorization']

    begin
      user_to_retrieve = @parser.auth0_id(@request)
      User.find_by_auth0_id(user_to_retrieve)
    rescue => exception
      print exception
      return nil
    end

  end
end
