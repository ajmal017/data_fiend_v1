require './helper'

class Hopper
  def initialize
  end

  def publish(request)
    require 'pry'; binding.pry
    queue = connect_to_queue(request.params['name']) 
    queue.publish(request.params['body'], persistent: true)
    @connection.close
  end

  private

    def connect_to_queue(name)
      connection.start
      channel = @connection.create_channel
      channel.queue(name, durable: true)
    end

    def connection
      @connection ||= Bunny.new(username: YamlParser.read('USERNAME'),
                password: YamlParser.read('PASSWORD'))
    end

end
