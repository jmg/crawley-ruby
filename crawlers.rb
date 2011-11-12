require 'net/http'
require 'response'
require 'scrapers'

class BaseCrawler
    attr_accessor :debug
    attr_accessor :max_depth
    attr_accessor :start_urls
    attr_accessor :scrapers

    def initialize start_urls, debug, max_depth
        @debug = debug
        @max_depth = max_depth
        @start_urls = start_urls
        @scrapers = [BaseScraper.new]
        @url_regex = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\\([\w\d]+\\)|([^[:punct:]\s]|\/)))/    
    end

    def manage_scrapers response
        for scraper in @scrapers
            scraper.scrape response
        end
    end

    def fetch url, depth
        return if depth > @max_depth

        url_obj = URI.parse url
        req = Net::HTTP::Get.new url_obj.path
        res = Net::HTTP.start(url_obj.host, url_obj.port) { |http|
            http.request req
        }

        response = Response.new
        response.html = res.body
        response.url = url

        manage_scrapers response

        urls = get_urls response.html
        
        #FIXME
        puts urls

        urls.each do |url|
          fetch url, depth + 1
        end
    end

    def start
        @start_urls.each do |url|
            fetch url, 0
        end
    end

    def get_urls html
        html.scan @url_regex
    end
end

crawler = BaseCrawler.new ["http://localhost/classes/BaseCrawler.html"], true, 1
crawler.start
