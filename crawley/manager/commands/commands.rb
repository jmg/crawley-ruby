require 'crawley/manager/commands/run'
require 'crawley/manager/commands/syncdb'
require 'crawley/manager/utils'

module crawley

    hash = { RunCommand::name => RunCommand,
             SyncdbCommand::name => SyncdbCommand }

    Commands = CustomHash.new hash
end
