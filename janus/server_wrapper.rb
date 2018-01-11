require 'require_all'
require_rel '/helper'

Rack::Handler::WEBrick.run(QueueInterfaceApp.new, Port: 9292)
