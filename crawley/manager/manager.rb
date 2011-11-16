require 'optparse'
require 'crawley/manager/commands/commands'

options = {}

def manage
    cmd = Commands.get ARGV[0]
    cmd.new.run
end
