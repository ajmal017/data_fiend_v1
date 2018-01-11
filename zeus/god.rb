require 'bunny'
require 'faraday'
require 'jwt'
require 'json'

conn = Bunny.new
conn.start
channel = conn.create_channel
in_queue = channel.queue('godQueueIn')
out_queue = channel.queue('godQueueOut')

web_token = JWT.encode(payload, Secrets.key, 'HS256')

response = Faraday.get(Secrets.janus_url) do |f|
  f.headers['X-Token'] = web_token 
  f.params['name'] = 'god_start'
  f.adaper Faraday.default_adapter
end

if response && response.body && response.status == 200
  in_queue.subscribe(:block => true) do |delivery_info, properties, body|
    count ||= 0
    sleep_time ||= 60
    if body
      command = GodRequest.new(body)
      command.send(out_queue) 
      sleep_time = 5
      count = 12
    end
    if count == 0
      sleep_time = 60
    end
    sleep(sleep_time)
  end
end
