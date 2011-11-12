require 'net/http'
require 'response'
require 'scrapers'

class BaseCrawler

    attr_accessor :start_urls
    attr_accessor :scrapers
    attr_accessor :max_depth

    #add your starting urls here
    @@start_urls = []

    #add your scraper classes here
    @@scrapers = []

    #specify you maximum crawling depth level
    @@max_depth = 0

    def initialize debug
        @debug = debug

        @@scrapers = @@scrapers.each do |scraper|
            scraper
        end
        @url_regex = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\\([\w\d]+\\)|([^[:punct:]\s]|\/)))/
    end


    def manage_scrapers response
        for scraper in @@scrapers
            puts scraper
            scraper.scrape response
        end
    end

    def fetch url, depth

        if depth > @@max_depth
            return
        end

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
        @@start_urls.each do |url|
            fetch url, 0
        end
    end

    def get_urls html
        html.scan @url_regex
    end
end
