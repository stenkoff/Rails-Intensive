require 'json'

class Flash
  attr_reader :now
  def initialize(req)
    flash = req.cookies['_!ruby_on_rails']
    @now = flash ? JSON.parse(flash) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie(
      '_!ruby_on_rails_flash',
      value: @flash.to_json,
      path: '/'
    )
  end
end
