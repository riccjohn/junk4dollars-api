class FakeAuthentication
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user
  end
end
