class FakeAuthentication
  def current_user=(user)
    @current_user = user
  end

  def current_user(_request)
    @current_user
  end
end
