require './helper'

class QueueInterfaceApp
  def initialize
    @threader ||= Threader.new
  end

  def call(env)
    begin
      QueueInterface.new(env: env, threader: threader).response
    rescue Exception => e
      [400, {'Content-Type' => 'json'}, [{ message: 'Invalid parameters'}.to_json]]
    end
  end

  private
    attr_reader :threader

end
