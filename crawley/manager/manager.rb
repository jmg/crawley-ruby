require 'optparse'
require_relative 'commands/commands'

options = {}

module Crawley

    def manage
        cmd = Commands.get ARGV[0]
        cmd.new.run
    end
end
