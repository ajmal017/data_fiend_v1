require './helper'

module Validator
  def is_that_you_dad?(env)
    authenticated? && env['HTTP_USER_AGENT'] == YamlParser.read('ZEUS_URL')
  end

  def demeter?(env)
    authenticated? && env['HTTP_USER_AGENT'] == YamlParser.read('DEMETER_URL')
  end

  def hera?(env)
    authenticated? && env['HTTP_USER_AGENT'] == YamlParser.read('HERA_URL')
  end

  def daedalus?(env)
    authenticated? && env['HTTP_USER_AGENT'] == YamlParser.read('DAEDALUS_URL')
  end

  def accepted_method?(env)
    YamlParser.read('HTTP_METHODS').include? env['REQUEST_METHODS'].downcase
  end

  def can_operate?(env)
    authenticated? && YamlParser.read('AUTHORITY_URLS').include? env['HTTP_USER_AGENT']
  end

  private

    def authenticated?(env)
      token = env['HTTP_X_TOKEN']
      headers = JWT.decode(token, YamlParser.read('HMAC_SECRET'), 'HS256')
      valid_user = ( headers[0]['username'] == YamlParser.read('USERNAME') )
      valid_pass = ( headers[0]['password'] == YamlParser.read('PASSWORD') )
      token && valid_user && valid_pass
    end

end
