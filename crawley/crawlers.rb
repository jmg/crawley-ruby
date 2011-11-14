require 'net/http'
require 'rubygems'
require 'mechanize'

require 'response'
require 'scrapers'

class BaseCrawler

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
        
        begin
            html = agent.get url
        rescue
            return nil
        end

        response = Response.new
        response.html = html
        response.url = url
        response
    end

    def fetch url, depth=0

        return if depth > @@max_depth

        response = get_response url
        return if response.nil?
        
        manage_scrapers response

        urls = get_urls response
        urls.each do |url|

            next if url.href.nil? or not @url_regex.match url.href
                    
            fetch url.href, depth + 1            
        end
    end

    def start
        @@start_urls.each do |url|
            fetch url
        end
    end

    def get_urls response
        response.html.links
    end
end
