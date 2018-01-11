require './helper'

class GetHandler
  def initialize(env, threader)
    @env = env
    @threader = threader
  end

  def respond
    request = Rack::Request.new(env)
    case request.path_info
    when '/god_start'
      if Validator.is_that_you_dad?(env)
        threader.pave_roads  
        Response.roads_paved
      end
    when '/get_hist'
      if Validator.demeter?(env)
        threader.get_hist(request.params)
        Response.message_sent
      else
        Response.invalid
      end
    else
      Response.invalid
    end
  end

  private
    attr_reader :env,
                :threader
end
