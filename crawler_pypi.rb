require 'crawlers'
require 'scrapers'

class PypiScraper < BaseScraper

    @@matching_urls = ["%localhost%"]

    def scrape response
        puts "dsd"
        super().scrape response
    end
end

class PypiCrawler < BaseCrawler

    #add your starting urls here
    @@start_urls = ["http://localhost:8000"]

    #add your scraper classes here
    @@scrapers = [PypiScraper.new]

    #specify you maximum crawling depth level
    @@max_depth = 1

end

crawler = PypiCrawler.new true
crawler.start
