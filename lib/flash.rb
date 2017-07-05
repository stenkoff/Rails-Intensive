require 'json'
require 'byebug'

class Flash
  attr_reader :now
  def initialize(req)
    cookie = req.cookies['_rails_lite_app']
    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(k,v)
    @flash[k.to_s] = v
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', value: @flash.to_json, path: '/')
  end
end
