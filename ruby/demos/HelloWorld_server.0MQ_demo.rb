#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'


context = ZMQ::Context.new

ap "Starting hello world server..."
responder = context.socket(ZMQ::REP)
responder.bind "tcp://*:5555"
#responder.bind "ipc:///tmp/zeroHW"

loop do
  request = ''
  responder.recv_string(request)

#  ap "received Hello"
#  sleep(1)
  responder.send_string "World"
end
