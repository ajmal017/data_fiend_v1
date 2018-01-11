from apollo import secrets
import sys
import pdb
import pika

credentials = { 'username': secrets.secrets['USERNAME'],
        'password': secrets.secrets['PASSWORD'] }
connection = pika.BlockingConnection(pika.ConnectionParameters(client_properties=credentials))
channel = connection.channel()
channel.queue_declare(queue = sys.argv[1])

def callback(channel, method, properties, body):
    pdb.set_trace()
    print(f"got a response from this shit here: {body}")
    sleep(1)

channel.basic_consume(callback, queue=sys.argv[1], no_ack=True)
channel.start_consuming()
    
