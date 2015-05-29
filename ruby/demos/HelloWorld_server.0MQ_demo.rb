#encoding: utf-8

require 'awesome_print'
require 'zmq'

context = ZMQ::Context.new

ap "Starting hello world srv..."
responder = context.socket(ZMQ::REP)
#responder.bind "tcp://*:5555"
responder.bind "tcp://10.10.55.54:5555"
#responder.bind "ipc:///tmp/zeroHW"

loop do
  request = responder.recv()

#  puts "received #{request}"
#  sleep(1)
  responder.send "World"
end
