module Crawley

    class Response

        attr_accessor :html
        attr_accessor :raw_html
        attr_accessor :url
        attr_accessor :headers

        def initialize url=nil, html=nil, raw_html=nil, headers=nil
            @url = url
            @html = html
            @raw_html = raw_html
            @headers = headers
        end
    end
end
