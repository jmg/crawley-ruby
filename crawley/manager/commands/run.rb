require_relative 'base'

module Crawley

    class RunCommand < Command
        
        @@name = "run"
        
        def self.name
            @@name
        end
        
        def run
        
            crawler = PypiCrawler.new true
            crawler.start
            
        end
        
    end
end
