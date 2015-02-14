#encoding: utf-8

require 'awesome_print'
require 'zmq'

context = ZMQ::Context.new

ap "Starting hello world server..."
responder = context.socket(ZMQ::REP)
#responder.bind "tcp://*:5555"
responder.bind "ipc:///tmp/zeroHW"

loop do
  request = responder.recv()

#  ap "received Hello"
#  sleep(1)
  responder.send "World"
end
