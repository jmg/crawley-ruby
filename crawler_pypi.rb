require 'crawlers'
require 'scrapers'

class PypiScraper < BaseScraper

    @@matching_urls = ["%pypi.python.org/pypi/%"]

    def scrape response
        puts response.url + " ->" + response.html
    end
end

class PypiCrawler < BaseCrawler

    #add your starting urls here
    @@start_urls = ["http://pypi.python.org/pypi"]

    #add your scraper classes here
    @@scrapers = [PypiScraper.new]

    #specify you maximum crawling depth level
    @@max_depth = 1

end

crawler = PypiCrawler.new true
crawler.start
