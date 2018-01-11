require './helper'

class PostHandler
  def initialize(env, threader)
    @env = env
    @threader = threader
  end

  def respond
    request = Rack::Request.new(env)
    case request.path_info
    when '/create_thread'
      if Validator.is_that_you_dad?(env)
        name = request.params['name']
        threader.create_thread(name)
        Response.thread_created
      else
        Response.invalid
      end
    when '/sell'
      if Validator.can_operate?(env)
        threader.sell(request.params['info'])
      else
        Response.invalid
      end
    when '/buy'
      if Validator.can_operate?(env)
        threader.buy(request.params['info'])
      else
        Response.invalid
      end
    when '/trade'
      if Validator.can_operate?(env)
        threader.trade(request.params['info'])
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
