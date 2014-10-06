#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'

context = ZMQ::Context.new(1)
publisher = context.socket(ZMQ::PUB)
publisher.bind "tcp://*:5556"

while true
  zipcode = rand(100)
  temperature = rand(215) - 80
  relhumidity = rand(50) + 10
  
  update = "%02d %d %d" % [zipcode, temperature, relhumidity]
  ap update
  publisher.send_string update
end
