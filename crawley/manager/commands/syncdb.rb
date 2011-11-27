require 'rubygems'
require 'data_mapper'
require 'dm-migrations'
require_relative 'base'


module Crawley

    class SyncdbCommand < Command
        
        @@name = "syncdb"
        
        def self.name
            @@name
        end
        
        def run
        
            DataMapper::Logger.new($stdout, :debug)
            DataMapper.setup(:default, 'sqlite::memory:')

            curr_dir = Dir.pwd
            DataMapper.setup(:default, 'sqlite:///' + curr_dir + '/base.db')
        
            DataMapper.auto_migrate!
        end
        
    end
end
