#encoding: utf-8

require 'bundler/setup'
require 'awesome_print'
require 'ffi-rzmq'

ap "Current 0MQ version is %d.%d.%d" % ZMQ::Util.version
