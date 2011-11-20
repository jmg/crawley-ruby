require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

@selectors_hash = Hash.new
@scrapers_hash = Hash.new
@crawlers = []

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

class Scraper
    attr_accessor :selectors

    def initialize selectors, table
        @selectors = selectors.values
        @table = table
    end
end

class Crawler
    def initialize scrapers, urls
        @scrapers = scrapers
        @urls = urls
    end

    def run
        @scrapers.each do |scraper|
            scraper.selectors.each do |selector|
                puts selector
            end
        end
        
        DataMapper::Logger.new($stdout, :debug)
        DataMapper.setup(:default, 'sqlite::memory:')

        DataMapper.setup(:default, 'sqlite:///' + Dir.pwd + '/base.db')

        DataMapper.auto_migrate!
    end
end

def url urls, &table_block
    @crawlers = []
    @scrapers_hash = Hash.new
    table_block.call
    if urls.respond_to? :each
        urls.each do |an_url|
            _add_crawlers an_url
        end
    else
        _add_crawlers urls
    end

    @crawlers.each do |crawler|
        crawler.run
    end
end

def _add_crawlers urls
    @crawlers.push Crawler.new @scrapers_hash.values, urls
end

def table table_name, &fields_block
    @selectors_hash = Hash.new
    fields_block.call
    @scrapers_hash[table_name] = Scraper.new @selectors_hash, Table.new(table_name, @selectors_hash) 
end

def field field_name, &selector_block
    @selectors_hash[field_name] = selector_block.call
end

if __FILE__ == $0
    url "http://pypi.python.org/pypi/cilantro/0.9b4" do
        table "MI_TABLA" do
            field "MI_CAMPO_0" do
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
