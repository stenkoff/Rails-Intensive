require 'json'

class Session
  def initialize(req)
    cookie = req.cookies['_off_the_rails']
    @data = cookie ? JSON.parse(cookie) : {}
  end

  def [](key)
    @data[key]
  end

  def []=(key, val)
    @data[key] = val
  end

  def store_session(res)
    res.set_cookie('_off_the_rails', {path: '/', value: @data.to_json})
  end
end
