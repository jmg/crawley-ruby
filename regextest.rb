require 'test/unit'

class RegexTest < Test::Unit::TestCase
  def test_regex_matches_simple_text
    re = /[0-9a-zA-Z]+/
    assert_equal false, re.match("hola").nil?
    assert_equal false, re.match("0123").nil?
    assert_equal false, re.match("HolaManola123").nil?
  end

  def test_more_complex_regex
    re = /http:\/\/www\.[0-9a-zA-Z]+\.[a-z]{2,3}/
    assert_equal false, re.match("http://www.google.com").nil?
  end

  def test_crawley_regex
    re = /((([a-z]+:\/\/)?|www\.)?[^\s()<>]+(?:\\([\w\d]+\\)|([^[:punct:]\s]|\/)))/    
    assert_equal false, re.match("http://www.google.com/hola?=bleh").nil?
  end
end
