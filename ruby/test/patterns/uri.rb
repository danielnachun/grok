require 'rubygems'
require 'Grok'
require 'test/unit'

class URIPatternsTest < Test::Unit::TestCase
  def setup
    @grok = Grok.new
    path = "#{File.dirname(__FILE__)}/../../../grok-patterns"
    @grok.add_patterns_from_file(path)
    @grok.compile("%{URI}")
  end

  def test_urls
    urls = ["http://www.google.com", "telnet://helloworld",
            "http://www.example.com/", "http://www.example.com/test.html", 
            "http://www.example.com/test.html?foo=bar", 
            "http://www.example.com/test.html?foo=bar&fizzle=baz", 
            "http://www.example.com:80/test.html?foo=bar&fizzle=baz", 
            "https://www.example.com:443/test.html?foo=bar&fizzle=baz", 
            "https://user@www.example.com:443/test.html?foo=bar&fizzle=baz", 
            "https://user:pass@somehost/fetch.pl",
            "puppet:///",
            "http://www.foo.com",
            "http://www.foo.com/",
            "http://www.foo.com/?testing",
            "http://www.foo.com/?one=two",
            "http://www.foo.com/?one=two&foo=bar",
            "foo://somehost.com:12345",
            "foo://user@somehost.com:12345",
            "foo://user@somehost.com:12345/",
            "foo://user@somehost.com:12345/foo.bar/baz/fizz",
            "foo://user@somehost.com:12345/foo.bar/baz/fizz?test",
            "foo://user@somehost.com:12345/foo.bar/baz/fizz?test=1&sink&foo=4",
            "http://www.google.com/search?hl=en&source=hp&q=hello+world+%5E%40%23%24&btnG=Google+Search"
           ]
            
    urls.each do |url|
      match = @grok.match(url)
      puts "Failed; #{url}" if !match
      assert_not_equal(false, match)
      assert_equal(url, match.captures["URI"][0])
    end
  end

end