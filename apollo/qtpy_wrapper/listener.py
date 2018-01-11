import secrets
import pika
from threading import Thread

class Listener:
    def __init__(self, queue_name):
        if !queue_name
            self.queue_name = 'god'
            self.threader = Threader()
        else:
            self.queue_name = queue_name


    def execute(self, *args, **kwargs):
        credentials = { 'username': secrets.secrets['USERNAME'], 'password': secrets.secrets['PASSWORD'] }
        connection = pika.BlockingConnection(pika.ConnectionParameters(client_properties=credentials))
        channel = connection.channel()
        channel.queue_declare(queue=self.queue_name)
        
        channel.basic_consume(callback, queue=self.queue_name)

    def callback(channel, method, properties, body):
        if self.queue_name == 'god':
           self.threader.process(body)
       else:
            
