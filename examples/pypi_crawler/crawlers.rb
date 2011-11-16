require 'crawley/crawlers'
require 'crawley/scrapers'

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

def run_crawler
    crawler = PypiCrawler.new true
    crawler.start
end

if __FILE__ == $0
    run_crawler
end
