require 'optparse'
require_relative 'commands/commands'

options = {}


def manage
  if ARGV[0].nil?
    puts "Some help file" #TODO
    return
  end

  cmd = Crawley::Commands.get ARGV[0]
  cmd.new.run
end
