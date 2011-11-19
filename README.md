# This is a ruby implementation of the crawley framework

------------------------------------------------------------------

### Comming Soon Features!

* High Speed WebCrawler built on EventMachine.
* Supports databases engines like Postgre, Mysql, Oracle, Sqlite.
* Command line tools.
* Extract data using your favourite tool. XPath or Pyquery (A Jquery-like library for python).
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
