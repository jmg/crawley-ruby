require 'optparse'
require 'commands/commands'

options = {}

cmd = Commands[ARGV[0]].new
cmd.run

