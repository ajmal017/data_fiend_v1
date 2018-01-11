import secrets
from qtpylib.algo import Algo

class ListenerAlgo(Algo):
    def on_start(self):
        print('algo initialized')

    def execute:

    #def perform(*args, **kwargs):
    #    credentials = { 'username': secrets.secrets['USERNAME'], 'password': secrets.secrets['PASSWORD'] }
    #    connection = pika.BlockingConnection(pika.ConnectionParameters(client_properties=credentials))
    #    channel = connection.channel()
    #    channel.queue_declare(queue=self.queue_name)
        
