require 'data_mapper'

module Persistance

    class Entity
  
        include DataMapper::Resource 
        property :id, Serial
        
    end
end
