module Crawley

  class BaseScraper
    def initialize
      @tables = []
    end

    def scrape response
      puts "scraping -> " + response.url
    end
  end
end
