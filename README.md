# This is a ruby implementation of the crawley framework

------------------------------------------------------------------

### Comming Soon Features!

* High Speed WebCrawler built on EventMachine.
* Supports databases engines like Postgre, Mysql, Oracle, Sqlite.
* Command line tools.
* Extract data using XPath.
* Cookie Handlers.

------------------------------------------------------------------

### Write your Models

```ruby
""" models.rb """

require 'rubygems'
require 'data_mapper'
require 'dm-migrations'    

class Package
    include DataMapper::Resource
        
    property :updated,      String
    property :package,      String
    property :description,  String    
end
```

------------------------------------------------------------------

### Write your Scrapers

```ruby
""" crawlers.rb """

require 'crawlers'
require 'scrapers'

class PypiScraper < BaseScraper

    @@matching_urls = ["%pypi.python.org/pypi%"]

    def scrape response        
        super response
    end
end

class PypiCrawler < BaseCrawler

    #add your starting urls here
    @@start_urls = ["http://pypi.python.org/pypi"]

    #add your scraper classes here
    @@scrapers = [PypiScraper.new]

    #specify your maximum crawling depth level
    @@max_depth = 1

end    
```
-------------------------------------------------------------------

### Or Write it with our DSL

```ruby
""" my_project.rb """

require 'rubygems'
require 'crawley'

crawl "http://www.somewebsite.com" do
  max_depth 1
  debug

  table "MY_SCRAPED_DATA" do
    field "TITLE" do
      field_mapping_action { |e| e.upper }
      "/html/body/h1"
    end

    field "TEXT" do
      "/html/p[0]"
    end
  end
end
```
