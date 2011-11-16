require 'crawley/manager/commands/base'

class SyncdbCommand < Command
    
    @@name = "syncdb"
    
    def self.name
        @@name
    end
    
    def run
        puts "sycdb cmd"
    end
    
end
