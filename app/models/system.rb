class System
  def self.authentication=(auth)
    @authentication = auth
  end

  def self.authentication
    parser = '??'
    @authentication ||= Authentication.new(parser)
  end
end
