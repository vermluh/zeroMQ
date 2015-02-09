#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'

COUNT = 50

context = ZMQ::Context.new

ap "Collection updates from weather server"

subscriber = context.socket(ZMQ::SUB)
subscriber.connect("tcp://localhost:5556")

filter = "42 "
subscriber.setsockopt(ZMQ::SUBSCRIBE, filter)

total_temp = 0
1.upto(COUNT) do |update_nbr|
  s = ''
  subscriber.recv_string(s)
  
  puts "received update number #{update_nbr}: #{s.red}"
  zipcode, temperature, relhumidity = s.split.map(&:to_i)
  total_temp += temperature
end

ap "Average temperature for zipcode '#{filter}' was #{total_temp / COUNT}F"
