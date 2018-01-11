require './helper'

class Threader
  def initialize
    @threads = {}
  end

  def publish(request)
    name = request.params['name']
    if name && YamlParser.read('ACCEPTED_THREADS').include?(name)
      hopper = Hopper.new
      hopper.publish(request)
    else
      raise Exception::SecurityError
    end
  end

  def pave_roads
    YamlParser.read('STARTUP_THREADS').each do |thread_name|
      create_thread(name)
    end
    start_apollo
  end

  def create_thread(name)
    if !threads[name]
      if YamlParser.read('ACCEPTED_THREADS').include?(name)
        threads[:name] = [(Thread.new { Listener.new(name, 1).listen })] 
      else
        raise Exception::SecurityError
      end
    else
      threads[name] << Thread.new { Listener.new(name, threads[:name].count + 1).listen }
    end
  end

  private
    attr_reader :threads
end
