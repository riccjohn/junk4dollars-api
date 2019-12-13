class System
  def self.authentication=(auth)
    @authentication = auth
  end

  def self.authentication
    @authentication ||= Authentication.new
  end
end
