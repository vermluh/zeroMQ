#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'

context = ZMQ::Context.new(1)

ap "Connecting to hello world server..."
requester = context.socket(ZMQ::REQ)
requester.connect "tcp://localhost:5555"

0.upto 9 do |request_nbr|
  ap "Sending request #{request_nbr}..."
  requester.send_string "Hello"
  
  reply = ''
  rc = requester.recv_string reply
  
  ap "Received reply #{request_nbr}: [#{reply}]"
end
