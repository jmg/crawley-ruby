require 'optparse'
require 'commands/commands'

options = {}

cmd = Commands.get ARGV[0]
cmd.new.run
