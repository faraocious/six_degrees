#!/usr/bin/env ruby

lib = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(lib) if File.directory?(lib) && !$LOAD_PATH.include?(lib)

 require 'heroku'
 require 'heroku/command'

 args = ARGV.dup
 ARGV.clear
 command = args.shift.strip rescue 'help'

 SixDegrees::Command.run(args)
