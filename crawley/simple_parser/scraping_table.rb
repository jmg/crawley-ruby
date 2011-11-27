require_relative '../persistance/relational/databases.rb'

module Crawley
  class DSLTable < Persistance::Entity

    def initialize name, selectors
      @name = name
      DSLTable.storage_names[:default] = @name
      selectors.keys.each do |key|
        DSLTable.property key, key.class 
      end
    end
  end
end
