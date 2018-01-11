require 'bunny'
require 'rspec'
require 'ib_mock'

running? = %x( python demeter/manage.py runserver )

if runnning?
  RSpec.feature "IB can send information" do
    context "to demeter" do
      it "to establish a connection" do
        conn = Bunny.new(host: 'localhost',
                         user: 'testuser',
                         password: 'testpassword',
                         #auth_mechanism: EXTERNAL
                        )
        conn.start
        channel = conn.create_channel
        out_queue = channel.queue("testing_queue_apollo_to_demeter")
        in_queue = channel.queue("testing_queue_demeter_to_apollo")

        begin
          in_queue.subscribe(block: true) do |delivery_info, properties, body|
            #set response to whatever you get back 
          end
        rescue Exception => error
          conn.close
        end
      
        channel.default_exchange.publish("Hey Demeter", routing_key: out_queue.name)
        sleep(10) 
        conn.close
      
        expect(response).to eq("Hey Apollo")
        expect(error).to eq(nil)
      end

      it "to send historical candlestick" do 

      end
    end
  end
else
  %x( echo 'error executing shell command in #{File.dirname(__FILE__)}' )
  exit(1)
end


conn = Bunny.new(host: 'localhost',
                 user: 'testuser',
                 password: 'testpassword',
                 #auth_mechanism: EXTERNAL
                )
conn.start
channel = conn.create_channel
out_queue = channel.queue("testing_queue_apollo_to_demeter")
in_queue = channel.queue("testing_queue_demeter_to_apollo")

in_queue.subscribe(block: true) do |delivery_info, properties, body|
  IBMock.process(delivery_info, properties, body)
end
