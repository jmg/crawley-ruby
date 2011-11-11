require 'net/http'
require 'response'
require 'scrapers'

class BaseCrawler

    def initialize start_urls, debug, max_depth
        @debug = debug
        @max_depth = max_depth
        @start_urls = start_urls
        @scrapers = [BaseScraper.new]
        @url_regex = "/\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))/"
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

        get_urls response.html
    end

    def start
        @start_urls.each do |url|
            fetch url
        end
    end

    def get_urls html
        urls = html.scan @url_regex
        urls.each do |url|
            url + "sdsd"
        end
    end
end


crawler = BaseCrawler.new ["http://www.google.com.ar/"], true, 1
crawler.start
