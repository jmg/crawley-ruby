require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

curr_dir = Dir.pwd
DataMapper.setup(:default, 'sqlite:///' + curr_dir + '/base.db')

class Package
    include DataMapper::Resource
        
    property :updated,      String
    property :package,      String
    property :description,  String    
end

DataMapper.auto_migrate!
