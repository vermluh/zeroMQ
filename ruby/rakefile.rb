#encoding: utf-8

require 'rubygems'
require 'bundler/setup'

demos_dir = 'demos'

Dirs = {
  :root  => File.dirname(__FILE__),
  :demos => File.expand_path(demos_dir)
}

demo_ext = '0MQ_demo.rb' # default file extension used when creating new demo files

task :default => [:help]

desc 'Initialize directories'
task :init do
  FileUtils.mkpath Dirs[:demos]
end

desc "create a new demo file in '#{Dirs[:demos]}'"
task :new_demo, [:title] => :init do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin 'Enter a name for your new demo file: '
  end
  title << '.' << demo_ext
  filename = File.join(Dirs[:demos], title)
  if File.exist? filename
    abort('rake aborted!') if ask("#{filename} already exists. Do you want to overwrite it?", ['y', 'n']) == 'n'
  end
  puts "Creating new demofile: #{filename}"
  open(filename, 'w') do |demo_file|
    demo_file.puts "#encoding: utf-8"
    demo_file.puts
    demo_file.puts "require 'bundler/setup'"
    demo_file.puts "require 'awesome_print'"
    demo_file.puts "require 'ffi-rzmq'"
  end
end

desc 'display rake task help'
task :help do
  puts ""
  puts " How-to:"
  puts " -------"
  puts " Display this help        'bundle exec rake' or 'bundle exec rake help'"
  puts " See available tasks:     'bundle exec rake -T'"
  puts " Create new demo file:    'bundle exec rake new_demo' or 'bundle exec rake new_demo[DEMONAME]'"
  
  demos = Dir.glob(File.join(Dirs[:demos], "**/*.#{demo_ext}"))
  demos.each do |demofile|
    basename = File.basename demofile
    filename = basename.chomp("." + demo_ext)
    puts " Run '#{filename}':#{' ' * (17 - filename.length) unless filename.length > 17} 'bundle exec ruby #{File.join(demos_dir, basename)}'"
  end
    
  puts ""
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /, '/')} ") while !valid_options.include? answer
  else
    answer = get_stdin message
  end
  answer
end
