require 'optparse'
require 'crawley/manager/commands/commands'

options = {}

module crawley

    def manage
        cmd = Commands.get ARGV[0]
        cmd.new.run
    end
end
