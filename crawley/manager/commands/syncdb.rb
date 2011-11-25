require_relative 'base'

module Crawley

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
