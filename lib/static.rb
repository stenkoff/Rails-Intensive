class Static
  def initialize(app)
    @app = app
    @root = :public
    @file_server = FileServer.new(root)
  end

  def call(env)
    req = Rack::Request.new(env)
    path = req.path
  end
end
