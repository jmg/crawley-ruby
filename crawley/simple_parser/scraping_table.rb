require_relative '../persistance/relational/databases.rb'

module Crawley
  class DSLTable < Persistance::Entity

    def initialize name, selectors
      @name = name
      Table.storage_names[:default] = @name
      selectors.keys.each do |key|
        Table.property key, key.class 
      end
    end
  end
end
