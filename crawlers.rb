require 'net/http'
require 'response'
require 'scrapers'

class BaseCrawler
            
    def initialize debug
        @debug = debug
        @scrapers = [BaseScraper.new]
    end
        
    def manage_scrapers response
        for scraper in @scrapers
            scraper.scrape response
        end
    end
    
    def fetch url                
        url_obj = URI.parse url
        req = Net::HTTP::Get.new url_obj.path
        res = Net::HTTP.start(url_obj.host, url_obj.port) { |http|
            http.request req
        }
        
        response = Response.new 
        response.html = res.body
        response.url = url
        
        manage_scrapers response
    end
    
    def start
        fetch "http://www.google.com/"
    end
end


crawler = BaseCrawler.new true 
crawler.start
