require_relative 'base'

module Crawley

  class RunCommand < Command

    @@name = "run"

    def self.name
      @@name
    end

    def run

      puts "running"
      #TODO

    end

  end
end
