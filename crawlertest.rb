require 'test/unit'
require 'crawlers'

class CrawlerTests < Test::Unit::TestCase
  def test_crawl_creation
	  crawler = BaseCrawler.new ["http://www.google.com.ar/"], true, 1
    assert_equal false, crawler.nil?
    assert_equal true, crawler.debug
    assert_equal 1, crawler.scrapers.size
    assert_equal 1, crawler.max_depth
    assert_equal "http://www.google.com.ar/", crawler.start_urls.first
  end
end
