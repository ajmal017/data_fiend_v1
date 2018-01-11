require './helper'

class Listener
  def initialize
    @conn = connection
  end

  def listen(name, number)
    conn.start
    @channel = conn.create_channel
    @channel.queue(name + number.to_s)
    @queue.subscribe(block: true) do |delivery_info, properties, body|
      usleep(30)
      target =
      path_addendum = 
      headers = 
      if body && target.in?(ENV['ACCEPTED_TARGETS'])
        send_json((target + path_addendum), headers, body) 
      end
      usleep(30)
    end
 
  end

  private
    attr_reader :conn

    def connection
      Bunny.new(host: ENV['RABBIT_HOST'],
                user: ENV['RABBIT_USER'],
                password: ENV['RABBIT_PASSWORD'])
    end

    def send_json(url, body, options={})
      f = Faraday.new(url) do 
        f.body = body
        f.adapter Faraday.default_adapter
      end
    end

end

