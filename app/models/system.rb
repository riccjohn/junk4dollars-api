class System
  def self.authentication=(auth)
    @authentication = auth
  end

  def self.authentication
    parser = Auth0Parser
    @authentication ||= Authentication.new(parser)
  end
end
