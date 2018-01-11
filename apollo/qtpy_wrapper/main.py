import secrets
from threading import Thread
from listener import Listener
from qtpylib.blotter import Blotter
from qtpylib.broker import Broker
from qtpylib.algo import Algo
from qtpylib.reports import Reports
#algorithm wrapper

class MainBlotter(Blotter):
    #def __init__(threader):
    # super()
    # self.threader = threader

    #def run
    #   threader.initialize_client(threader, super)
    pass

blotter = MainBlotter(
            dbskip = True,
            orderbook = True
            )
listener = Listener()
blotter_thread = Thread(target = blotter.run) 
master_thread = Thread(target = listener.execute)
blotter_thread.start()
master_thread.start()
