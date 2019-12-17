class System
  def self.authentication=(auth)
    @authentication = auth
  end

  def self.authentication
    @authentication ||= FakeAuthentication.new
  end
end
