require './helper'

class QueueInterface
  def initialize(args={})
    @env = args[:env]
    @threader = args[:threader]
  end

  def response
    info = return_info
    self.send(env['REQUEST_METHOD'].downcase) if Validator.accepted_method?(env)
  end

  def post
    PostHandler.new(env, threader).respond 
  end

  def get
    GetHandler.new(env, threader).respond
  end

  private
    attr_reader :env,
                :threader

end
