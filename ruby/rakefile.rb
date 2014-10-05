#encoding: utf-8

require 'rubygems'
require 'bundler/setup'

demo_ext = 'demo.rb' # default file extension used when creating new demo files

task :default => [:help]

desc 'display rake task help'
task :help do
  puts ""
  puts " How-to:"
  puts " -------"
  puts " Display this help                  'rake'"
  puts " See available tasks:               'rake -T'"
  
  demos = Dir.glob("**/*.#{demo_ext}")
    
  puts ""
end
