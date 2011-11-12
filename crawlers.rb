require 'net/http'
require 'rubygems'
require 'mechanize'

require 'response'
require 'scrapers'

class BaseCrawler

    attr_accessor :debug
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

        @url_regex = /^((https?):\/\/)?([a-z\d]+([\-\.][a-z\d]+)*\.[a-z]{2,6})((:(\d{1,5}))?(\/.*)?)?$/ix
    end


    def manage_scrapers response
        for scraper in @@scrapers
            scraper.scrape response
        end
    end

    def get_response url

        agent = Mechanize.new
        agent.user_agent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.1.4) Gecko/20091016 Firefox/3.5.4'
        html = agent.get url

        response = Response.new
        response.html = html
        response.url = url
        response
    end

    def fetch url, depth

        return if depth > @@max_depth

        response = get_response url
        manage_scrapers response

        urls = get_urls response
        puts urls
        urls.each do |url|
            return if url.href.nil? or not @url_regex.match url.href
            puts url.href
            fetch url.href, depth + 1
        end
    end

    def start
        @@start_urls.each do |url|
            fetch url, 0
        end
    end

    def get_urls response
        response.html.links
    end
end
