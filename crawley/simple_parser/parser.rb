@selectors_hash = Hash.new
@crawlers = []

class Table
    def initialize name, selectors
        @name = name
        @fields = selectors.keys
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
    end
end

def url urls, &table_block
    @crawlers = []
    if urls.respond_to? :each
        urls.each do |an_url|
            _add_crawlers table_block, an_url
        end
    else
        _add_crawlers table_block, urls
    end

    @crawlers.each do |crawler|
        crawler.run
    end
end

def _add_crawlers table_block, urls
    @crawlers.push Crawler.new table_block.call.values, urls
end

def table table_name, &fields_block
    @selectors_hash = Hash.new
    scrapers_hash = Hash.new
    fields_block.call
    scrapers_hash[table_name] = Scraper.new @selectors_hash, Table.new(table_name, @selectors_hash) 
    scrapers_hash
end

def field field_name, &selector_block
    @selectors_hash[field_name] = selector_block.call
end


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
