require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# An in-memory Sqlite3 connection:
DataMapper.setup(:default, 'sqlite::memory:')


curr_dir = Dir.pwd
# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite:///' + curr_dir + '/base.db')

class Post
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :title,      String    # A varchar type string, for short strings
  property :body,       Text      # A text block, for longer string data.
  property :created_at, DateTime  # A DateTime, for any date you might like.
end


DataMapper.auto_migrate!
