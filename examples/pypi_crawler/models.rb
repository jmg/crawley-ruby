require 'crawley'

class Package
    include DataMapper::Resource
        
    property :updated,      String
    property :package,      String
    property :description,  String    
end
