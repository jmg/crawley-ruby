require 'rubygems'  
require 'rake'  
require 'echoe'  
  
Echoe.new('crawley', '0.0.1') do |p|  
  p.description     = "Pythonic Scraping / Crawling FrameWork built On EventMachine"  
  p.url             = "http://github.com/jmg/crawley-ruby"  
  p.author          = "Crawley Developers"  
  p.email           = "jmg.utn@gmail.com"  
  p.development_dependencies = []
end  
  
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }  
