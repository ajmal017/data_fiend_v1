# data_fiend_v1

## Overview:

  Data Fiend is a multithreaded investing machine built in Python and Ruby that will analyze market trends collected from Interactive Broker, Investopedia, Coinbase, Block.io, and external datasets. Each subapplication queries a queue and/or Janus to communicate with the others.
  
## Subapplications

### Zeus

  Zeus is a "god process" and shell script that acts at the highest level of the application. The shell script runs each subapplication in the required order and can run integration tests spread throughout. The "god process" sends a message to the queue upon initialization to spawn a number of threads, and can be asked to spawn more or kill processes through the "god" queue.

### Janus

  Janus is a Ruby Rack application and custom wrapper for RabbitMQ that can accept HTTP requests and validate them for security by using JSON Web Token and by checking their IP addresses against a private ledger. Once it receives a request and validates, it sends a confirmation message in a response to the subapplication that made the query and adds a message to the queue. It also subscribes to the RabbitMQ and sends an HTTP request to the appropriate subapplication. Furthermore, it can send messages over the "god" queue to Zeus from subapplications that might be experiencing delays. Upon response from Zeus, Janus opens up a new ruby slave process that subscribes to the correct queue. Slave threads can be killed in the same way.
  
### Apollo

  Apollo is a multithreaded interface with Interactive Brokers that utilizes the library QtPyLib for Python to retreive data and send requests to buy, sell, and trade. it starts a session with the Interactive Brokers in the main thread subscribes to the queue with another. From there, more threads can be spawned or killed that run QtPyLib "Algos" specific to the financial instrument given. These subscriptions add messages to the queue every minute, reporting on the bar or tick value of the given instrument. From the queue, Apollo can also be called to get historical data.
    **Additions Proposed:**
    * Investopedia simulator API, which allows a virtually unlimited amount of market data to be downloaded, and a simulated account balance of $100,000
    
### Hera

  Hera is a (very primordial staging area for crunchy metaprogramming concepts and) Rails application that fetches current and historical data from Coinbase.
  **Additions Proposed:**
  * A chron job to query Coinbase every set interval for cryptocurrency market data
  * Integration with Block.IO API and/or other APIs that are faster than Coinbase
    
### Demeter

  Demeter is a Django application that utilizes the SciPy libraries to perform linear regression, multiple linear regression, the fourier transformation, fibonacci analysis, the hankel tranformation, and others on collected data
  **Additions Proposed:**
  * Adding Matplotlib graphs to the admin dashboard for further analysis
  * AWS database management and machine learning algorithms
  * Change from Postgresql to Neo4j, a non-relational graph database that would be more easily traversed by a neural network
  
### Daedalus

  Daedalus would be a neural network that would eventually be able to ask every other subapplication for data and statistical advice, which it would then learn to optimize.
  **Proposed Features:**
  * Bayesian propogation of "neuron objects"
  * Abstraction and serialization of mathematical functions into objects (in a very clever and Godelian kind of way obviously), to be combined at will. Because why not.
  * Magic
