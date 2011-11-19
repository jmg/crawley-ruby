module crawley

    class BaseScraper

        def scrape response
            puts "scraping -> " + response.url
        end
    end
end
