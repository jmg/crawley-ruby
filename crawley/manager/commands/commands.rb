require_relative 'run'
require_relative 'syncdb'
require_relative '../utils'

module Crawley

    hash = { RunCommand::name => RunCommand,
             SyncdbCommand::name => SyncdbCommand }

    Commands = CustomHash.new hash
end
