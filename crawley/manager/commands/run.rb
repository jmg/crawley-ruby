require_relative 'base'

module Crawley

    class RunCommand < Command
        
        @@name = "run"
        
        def self.name
            @@name
        end
        
        def run
            puts "run cmd"
        end
        
    end
end
