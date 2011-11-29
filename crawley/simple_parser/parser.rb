require 'rubygems'

require_relative '../crawlers.rb'
require_relative '../scrapers.rb'
require_relative 'scraping_table.rb'

@selectors_hash = Hash.new
@scrapers_hash = Hash.new
@post_hash = Hash.new
@login_hash = Hash.new
@login_data = Hash.new
@crawlers = []
@allowed_urls = []
@black_list = []
@proxy_host = ""
@proxy_username = ""
@proxy_password = ""
@proxy_port = 80
@max_depth = 0
@max_concurrency_level = 25
@requests_delay = 100
@requests_deviation = 300
@search_all_urls = true
@debug = false
@mapping_action = nil

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
  @proxy_host = ""
  @proxy_user = ""
  @proxy_pass = ""
  @proxy_port = 80
  @max_depth = 0
  @max_concurrency_level = 25
  @requests_delay = 100
  @requests_deviation = 300
  @scrapers_hash = Hash.new
  @post_hash = Hash.new
  @search_all_urls = true
  @debug = false
  table_block.call
  if urls.respond_to? :each
    urls.each do |an_url|
      _add_crawlers an_url
    end
  else
    _add_crawlers urls
  end

  @crawlers.each do |crawler|
    crawler.start
  end
end

# Private Method
#
# Action:
#   Creates and adds the crawler to the crawlers list
def _add_crawlers urls
  
  crawler = Crawley::BaseCrawler.new @debug 

  crawler.instance_variable_set :@start_urls, urls  
  crawler.instance_variable_set :@max_depth, @max_depth  
  crawler.instance_variable_set :@allowed_urls, @allowed_urls  
  crawler.instance_variable_set :@black_list, @black_list  
  crawler.instance_variable_set :@max_concurrency_level, @max_concurrency_level  
  crawler.instance_variable_set :@requests_deviation, @requests_deviation
  crawler.instance_variable_set :@search_all_urls, @search_all_urls
  crawler.instance_variable_set :@login, @login
  crawler.instance_variable_set :@post, @post
  crawler.instance_variable_set :@proxy_host, @proxy_host
  crawler.instance_variable_set :@proxy_user, @proxy_user
  crawler.instance_variable_set :@proxy_pass, @proxy_pass
  crawler.instance_variable_set :@proxy_port, @proxy_port

  @crawlers.push crawler
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
#   miliseconds: The deviation for the delay randomization
#
# Action:
#   Sets the request deviation time for the requests, must be inside the crawl
#   statement
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
#   a_boolean: A Boolean value, if true, the crawler is set in debug mode
#
# Actions:
#   Sets the crawler's debug option
def debug a_boolean=true
  @debug = a_boolean
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
  h = Hash.new
  h[param_name] = param_value_block.call
  h
end

# Public Method
#
# Params:
#   an_url: An URL for the proxy
#   proxy_values_block: A Block containing the required data for the proxy
#
# Example:
#   crawl "somewhere" do
#     proxy "my_proxy_url" do
#       proxy_username "my_username"
#       proxy_password "my_password"
#       proxy_port 8080
#     end
#     #...
#   end
#
# Actions:
#   Sets the proxy information for the crawler, must be inside the crawl
#   statement
def proxy an_url, &proxy_values_block
  @proxy_host = an_url
  proxy_values_block.call
end

# Public Method
#
# Params:
#   p_user: A String containing the username for the proxy
#
# Actions:
#   Sets the username for the proxy
def proxy_username p_user=""
  @proxy_username = p_user
end

def proxy_password p_pass=""
  @proxy_password = p_pass
end

def proxy_port p_port=80
  @proxy_port = p_port
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
  scraper = Crawley::BaseScraper.new
  scraper.instance_variable_set :@selectors, @selectors_hash
  scraper.instance_variable_set :@tables, 
    (scraper.instance_variable_get :@tables).push(Crawley::DSLTable.new table_name, @selectors_hash)
  @scrapers_hash[table_name] = scraper 
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
  @mapping_property = nil
  xpath = selector_block.call
  @selectors_hash[field_name] = [xpath, @mapping_property.clone]
end

# Public Method
#
# Params:
#   mapping_action_block: A Block containing any custom action you want when
#     storing the data field, must contain 1 argument
#
# Example:
#   crawl "somewhere" do
#     table "my_table" do
#       field "my_field"
#         field_mapping_action { |d| d.lower }
#         "/some/xpath/to/my/data"
#       end
#       #...
#     end
#     #...
#   end
#
# Actions:
#   Sets the mapping custom action before storing the data, must be inside a
#   field statement, must be the first line inside the field statement if used
def field_mapping_action &mapping_action_block
  @mapping_action = Proc.new mapping_action_block
end
