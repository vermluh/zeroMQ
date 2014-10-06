#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'

COUNT = 10

context = ZMQ::Context.new(1)

ap "Collection updates from weather server"

subscriber = context.socket(ZMQ::SUB)
subscriber.connect("tcp://localhost:5556")

filter = "42 "
subscriber.setsockopt(ZMQ::SUBSCRIBE, filter)

# Process 100 updates
total_temp = 0
1.upto(COUNT) do |update_nbr|
  s = ''
  subscriber.recv_string(s)
  
  puts "received update: #{s.red}"
  zipcode, temperature, relhumidity = s.split.map(&:to_i)
  total_temp += temperature
end

ap "Average temperature for zipcode '#{filter}' was #{total_temp / COUNT}F"
