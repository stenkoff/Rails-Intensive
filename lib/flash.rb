require 'json'

class Flash
  attr_reader :now
  def initialize(req)
    flash = req.cookies['_off_the_rails_flash']
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
      '_off_the_rails_flash',
      value: @flash.to_json,
      path: '/'
    )
  end
end
