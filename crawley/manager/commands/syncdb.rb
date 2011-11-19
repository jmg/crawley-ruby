require 'crawley/manager/commands/base'

module crawley

    class SyncdbCommand < Command
        
        @@name = "syncdb"
        
        def self.name
            @@name
        end
        
        def run
            puts "sycdb cmd"
        end
        
    end
end
