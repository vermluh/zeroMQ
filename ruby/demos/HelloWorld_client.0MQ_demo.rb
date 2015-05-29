#encoding: utf-8

require 'awesome_print'
require 'benchmark'
require 'zmq'

context = ZMQ::Context.new(1)

ap "Connecting to hello world server..."
@requester = context.socket(ZMQ::REQ)
#@requester.connect "tcp://localhost:5555"
@requester.connect "tcp://10.10.55.54:5555"
#@requester.connect "ipc:///tmp/zeroHW"

@count = 10000
def exec_demo()
  1.upto @count do |request_nbr|
#    ap "Sending request #{request_nbr}..."
    @requester.send "Hello"
  
    reply = @requester.recv
  
#    ap "Received reply #{request_nbr}: [#{reply}]"
  end
end

seconds = Benchmark.realtime{exec_demo}
puts "#{@count}".yellow + " executions took" + " #{seconds}".yellow + " seconds"
puts "single message: " + "#{seconds/@count}".yellow + " seconds"
puts "#{@count/seconds}".yellow + " messages / sec"
