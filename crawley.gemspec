## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'crawley'
  s.version           = '0.0.1'
  s.date              = '2011-11-27'
  s.rubyforge_project = 'crawley'
  s.require_paths = ["crawley"]

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "A scraping ang crawling framework built on eventmachine"
  s.description = "Crawley Framework"

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Crawley-developers"]
  s.email    = 'crawley-developers@googlegroups.com'
  s.homepage = 'http://www.crawley-project.com.ar'

  ## If your gem includes any executables, list them here.
  s.executables = ["rcrawley"]

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8"]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  s.add_dependency('data_mapper', [">= 1.1.0", "< 2.0.0"])
  s.add_dependency('mechanize', [">= 2.0.0", "< 3.0.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    README.md
    Rakefile
    bin/rcrawley
    crawley.gemspec
    crawley/crawlers.rb
    crawley/crawley.rb
    crawley/manager/commands/base.rb
    crawley/manager/commands/commands.rb
    crawley/manager/commands/run.rb
    crawley/manager/commands/syncdb.rb
    crawley/manager/manager.rb
    crawley/manager/utils.rb
    crawley/persistance/relational/databases.rb
    crawley/response.rb
    crawley/scrapers.rb
    crawley/simple_parser/doc/Crawler.html
    crawley/simple_parser/doc/Object.html
    crawley/simple_parser/doc/Scraper.html
    crawley/simple_parser/doc/Table.html
    crawley/simple_parser/doc/created.rid
    crawley/simple_parser/doc/images/add.png
    crawley/simple_parser/doc/images/brick.png
    crawley/simple_parser/doc/images/brick_link.png
    crawley/simple_parser/doc/images/bug.png
    crawley/simple_parser/doc/images/bullet_black.png
    crawley/simple_parser/doc/images/bullet_toggle_minus.png
    crawley/simple_parser/doc/images/bullet_toggle_plus.png
    crawley/simple_parser/doc/images/date.png
    crawley/simple_parser/doc/images/delete.png
    crawley/simple_parser/doc/images/find.png
    crawley/simple_parser/doc/images/loadingAnimation.gif
    crawley/simple_parser/doc/images/macFFBgHack.png
    crawley/simple_parser/doc/images/package.png
    crawley/simple_parser/doc/images/page_green.png
    crawley/simple_parser/doc/images/page_white_text.png
    crawley/simple_parser/doc/images/page_white_width.png
    crawley/simple_parser/doc/images/plugin.png
    crawley/simple_parser/doc/images/ruby.png
    crawley/simple_parser/doc/images/tag_blue.png
    crawley/simple_parser/doc/images/tag_green.png
    crawley/simple_parser/doc/images/transparent.png
    crawley/simple_parser/doc/images/wrench.png
    crawley/simple_parser/doc/images/wrench_orange.png
    crawley/simple_parser/doc/images/zoom.png
    crawley/simple_parser/doc/index.html
    crawley/simple_parser/doc/js/darkfish.js
    crawley/simple_parser/doc/js/jquery.js
    crawley/simple_parser/doc/js/navigation.js
    crawley/simple_parser/doc/js/search.js
    crawley/simple_parser/doc/js/search_index.js
    crawley/simple_parser/doc/js/searcher.js
    crawley/simple_parser/doc/rdoc.css
    crawley/simple_parser/doc/table_of_contents.html
    crawley/simple_parser/parser.rb
    crawley/simple_parser/scraping_table.rb
    examples/pypi_crawler/crawlers.rb
    examples/pypi_crawler/models.rb
    tests/crawler_test.rb
    tests/regex_test.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
