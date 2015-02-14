#encoding: utf-8

require 'awesome_print'
require 'benchmark'
require 'zmq'

context = ZMQ::Context.new

ap "Connecting to hello world server..."
@requester = context.socket(:REQ)
@requester.connect "tcp://192.168.178.66:5555"
#@requester.connect "tcp://127.0.0.1:5555"
#@requester.connect "ipc:///tmp/zeroHW"

@count = 10000
def exec_demo()
  1.upto @count do |request_nbr|
    #ap "Sending request #{request_nbr}..."
    @requester.send "Hello"
  
    reply = @requester.recv
  
    #ap "Received reply #{request_nbr}: [#{reply}]"
  end
end

seconds = Benchmark.realtime{exec_demo}
puts "#{@count}".yellow + " executions took" + " #{seconds}".yellow + " seconds"
puts "single message: " + "#{seconds/@count}".yellow + " seconds"
puts "#{@count/seconds}".yellow + " messages / sec"
