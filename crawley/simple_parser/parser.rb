require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

@selectors_hash = Hash.new
@scrapers_hash = Hash.new
@post_hash = Hash.new
@login_hash = Hash.new
@login_data = Hash.new
@crawlers = []
@allowed_urls = []
@black_list = []
@max_depth = 0
@max_concurrency_level = 25
@requests_delay = 100
@requests_deviation = 300
@search_all_urls = true

# Mock implementation of Table class
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

# Mock implementation of Scraper class
class Scraper
  attr_accessor :selectors

  def initialize selectors, table
    @selectors = selectors.values
    @table = table
  end
end

# Mock implementation of Crawler class
class Crawler
  def initialize scrapers, urls, max_depth, 
    allowed_urls, black_list, 
    max_concurrency_level, requests_delay,
    requests_deviation, search_all_urls,
    login, post
    @scrapers = scrapers
    @urls = urls
    @max_depth = max_depth
    @allowed_urls = allowed_urls
    @black_list = black_list
    @max_concurrency_level = max_concurrency_level
    @requests_delay = requests_delay
    @requests_deviation = requests_deviation
    @search_all_urls = search_all_urls
    @login = login
    @post = post
  end

  def run
    @scrapers.each do |scraper|
      scraper.selectors.each do |selector|
        puts selector
      end
    end

    puts @max_depth

    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, 'sqlite::memory:')
    DataMapper.setup(:default, 'sqlite:///' + Dir.pwd + '/base.db')
    DataMapper.auto_migrate!
  end
end


# Public Method
#
# Parameters:
#    urls:           A String or String Array of the URLs to Crawl
#    table_block:    A Block containing the rest of the DSL
#
# Returns:
#    nil
#
# Example:
#    crawl "http://www.google.com" do
#      table "GOOGLE_DATA" do
#        field "urls" do
#          "a/valid/xpath/to/some/google/url"
#        end
#        #...
#      end
#      #...
#    end
#
# Action:
#    Creates the DataBase, Scrapers and Crawlers for the requested data
#    structure and launches the crawler
def crawl urls, &table_block
  @crawlers = []
  @allowed_urls = []
  @black_list = []
  @max_depth = 0
  @max_concurrency_level = 25
  @requests_delay = 100
  @requests_deviation = 300
  @scrapers_hash = Hash.new
  @post_hash = Hash.new
  @search_all_urls = true
  table_block.call
  if urls.respond_to? :each
    urls.each do |an_url|
      _add_crawlers an_url, @max_depth, @allowed_urls, 
        @black_list, @max_concurrency_level,
        @requests_delay, @requests_deviation,
        @search_all_urls, @login_hash, @post_hash
    end
  else
    _add_crawlers urls, @max_depth, @allowed_urls, 
      @black_list, @max_concurrency_level,
      @requests_delay, @requests_deviation,
      @search_all_urls, @login_hash, @post_hash
  end

  @crawlers.each do |crawler|
    crawler.run
  end
end

# Private Method
#
# Action:
#   Creates and adds the crawler to the crawlers list
def _add_crawlers urls, max_depth,
  allowed_urls, black_list, 
  max_concurrency_level, requests_delay,
  requests_deviation, search_all_urls,
  login, post
  @crawlers.push Crawler.new @scrapers_hash.values, urls, 
    max_depth, allowed_urls,
    black_list, max_concurrency_level,
    requests_delay, requests_deviation,
    search_all_urls, login, post
end

# Public Method
#
# Params:
#   depth: The maximum depth of the crawler
#
# Action:
#   Sets the maximum depth of the crawler, must be inside the crawl statement
def max_depth depth=0
  @max_depth = depth
end

# Public Method
#
# Params:
#   level: The maximum concurrency level of the crawler threads
#
# Action:
#   Sets the maximum concurrency level of the crawler threads, must be inside
#   the crawl statement
def max_concurrency_level level=25
  @max_concurrency_level = level
end

# Public Method
#
# Params:
#   miliseconds: The average time between requests when crawling the web
#
# Action:
#   Sets the average time between requests of the crawler, must be inside the
#   crawl statement
def requests_delay miliseconds=100
  @requests_delay = miliseconds
end

# Public Method
#
# Params:
#   miliseconds: TODO
#
# Action:
#   TODO
def requests_deviation miliseconds=300
  @requests_deviation = miliseconds
end

# Public Method
#
# Params:
#   url_list: A list of the whitelisted URLs for scraping, the default value is
#   any URL
#
# Actions:
#   Sets the URL whitelist
def allowed_urls url_list=[]
  @allowed_urls = url_list
end

# Public Method
#
# Params:
#   url_list: A list of the blacklisted URLs for scraping, the default value is
#   none
#
# Actions:
#   Sets the URL blacklist
def black_list url_list=[]
  @black_list = url_list
end

# Public Method
#
# Params:
#   a_boolean: A Boolean value, if true, the crawler doesn't take account of
#   allowed_urls nor black_list
#
# Actions:
#   Sets the crawler to use or not the black_list and allowed_urls
def search_all_urls a_boolean=true
  @search_all_urls = a_boolean
end

# Public Method
#
# Params:
#   login_url: The first URL the crawler will use, it will authenticate to it
#   using the parameters given in the login_block
#
#   login_block: A Block containing Login data
#
# Example:
#   crawl "somewhere" do
#     login "login_url" do
#       username "my_user"
#       password "my_password"
#       #...
#     end
#     #...
#   end
#
# Action:
#   Sets the login data for the crawler, must be inside the crawl statement
def login login_url, &login_block
  @login_hash = Hash.new
  @login_data = Hash.new
  login_block.call
  @login_hash[login_url] = @login_data
end

# Public Method
#
# Params:
#   user_name: Your Username
#
#   default_field_name: The username field of the login URL, 
#   it defaults with "user"
#
# Actions:
#   Sets the username for the Login data, must be inside the login statement
def username user_name, default_field_name="user"
  @login_hash[default_field_name] = user_name
end

# Public Method
#
# Params:
#   pass: Your Password
#
#   default_field_name: The password field of the login URL,
#   if defaults with "pass"
#
# Actions:
#   Sets the password for the login data, must be inside the login statement
def password pass, default_field_name="pass"
  @login_hash[default_field_name] = pass
end

# Public Method
#
# Params:
#   param_name: Additional Login parameter name
#
#   param_value_block: A Block containing the fields value
#
# Actions:
#   Sets any additional parameter for the login data, must be inside the login
#   statement
def login_param param_name, &param_value_block
  @login_data[param_name] = param_value_block.call
end

# Public Method
#
# Params:
#   an_url: An URL on which the crawler will have to do POST requests
#
#   post_block: A Block with the data for the given URL
#
# Example:
#   crawl "somewhere" do
#     post "an_url_to_post" do
#       param "param_name" do
#         "param_value"
#       end
#       #...
#     end
#     #...
#   end
#
# Action:
#   Sets the URLs with it's data to use when requesting the URLs, must be
#   inside the crawl statement
def post an_url, &post_block
  @post_hash[an_url] = post_block.call
end

# Public Method
#
# Params:
#   param_name: A String with the parameter name for the POST
#
#   param_value_block: A Block containing the value for the given parameter
#
# Actions:
#   Sets the value for the given parameter for the post action, must be inside
#   the post statement
def param param_name, &param_value_block

end

# Public Method
#
# Params:
#   table_name: A String with the table name for the DataBase
#
#   fields_block: A Block containing the table fields data
#
# Example:
#   crawl "somewhere" do
#     table "my_table" do
#       field "my_field" do
#         "some/valid/xpath"
#       end
#       #...
#     end
#     #...
#   end
#
# Action:
#   Sets the necessary information for the framework to create the tables
#   needed for the DataBase generation, must be inside a crawl statement
def table table_name, &fields_block
  @selectors_hash = Hash.new
  fields_block.call
  @scrapers_hash[table_name] = Scraper.new @selectors_hash, Table.new(table_name, @selectors_hash) 
end

# Public Method
#
# Params:
#   field_name: A String with the field's name
#
#   selector_block: A Block containing a valid XPath selector
#
# Actions:
#   Sets the fields data for generating the tables and scrapers, must be inside
#   a table statement
def field field_name, &selector_block
  @selectors_hash[field_name] = selector_block.call
end

if __FILE__ == $0
  #Example implementation of the DSL using the full spectrum of the
  #possibilities
  crawl "http://pypi.python.org/pypi/cilantro/0.9b4" do #Required
    max_depth 2                     #Optional: defaults in 0
    allowed_urls []                 #Optional: defaults in []
    black_list []                   #Optional: defaults in []
    max_concurrency_level 1000      #Optional: defaults in 25
    requests_delay 1000             #Optional: defaults in 100
    requests_deviation 1000         #Optional: defaults in 300
    search_all_urls                 #Optional: defaults in true, 
    #to make it false just call it
    #search_all_urls false   

    login "login_url" do            #Optional: defaults in {}
      username "username"
      password "password"
      login_param "param_name" do
        "value"
      end
      #  ...
    end

    post "an_url" do                #Optional: defaults in {}
      {'param_1' => 'value_1', 'param_2' => 'value_2'}
    end

    post "another_url" do
      {'param_3' => 'value_3'}
    end

    table "MI_TABLA" do             #Required
      field "MI_CAMPO_0" do         #Required
        "/html/body/div[5]/div/div/div[3]/ul/li/span"
      end

      field "MI_CAMPO_1" do
        "/html/body/div[5]/div/div/div[3]/ul/li[3]/span"
      end

      field "MI_CAMPO_2" do
        "/html/body/div[5]/div/div/div[3]/ul/li[4]/span"
      end
    end
  end
end
