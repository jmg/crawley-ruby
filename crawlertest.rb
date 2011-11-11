require 'test/unit'
require 'crawlers'

class CrawlerTests < Test::Unit::TestCase
  def test_crawl_creation
	  crawler = BaseCrawler.new true
    assert_equal false, crawler.nil?
    assert_equal true, crawler.debug
    assert_equal 1, crawler.scrapers.size
  end
end
