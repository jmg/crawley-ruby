module Crawley
  class Table
    include DataMapper::Resource 

    property :id, Serial

    def initialize name, selectors
      @name = name
      Table.storage_names[:default] = @name
      selectors.keys.each do |key|
        Table.property key, key.class 
      end
    end
  end
end
