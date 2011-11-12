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
    re = /^((https?):\/\/)?([a-z\d]+([\-\.][a-z\d]+)*\.[a-z]{2,6})((:(\d{1,5}))?(\/.*)?)?$/ix
    list = "http://www.google.com/hola?=bleh".scan(re)
    assert_false list.length == 0
  end
end
