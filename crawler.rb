require 'net/http'

class BaseCrawler
    
    def initialize debug
        @debug = debug
    end
    
    def fetch url                
        url = URI.parse(url)        
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        if @debug:        
            puts res.body
        end
    end
    
    def start
        fetch "http://www.google.com/"
    end
end


crawler = BaseCrawler.new true 
crawler.start
