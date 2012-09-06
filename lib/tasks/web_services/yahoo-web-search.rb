#!/c/Ruby193/bin/ruby
# yahoo-web-search.rb

require 'open-uri'
require 'rexml/document'
require 'cgi'

BASE_URI = 'http://api.search.yahoo.com/WebSearchService/V1/webSearch'

def print_page_titles(term)
  # Fetch a resource: an XML document full of search results.
  term = CGI::escape(term)
  xml = open(BASE_URI + "?appid=restbook&query=#{term}").read
  
  # Parse the XML document into a data structure.
  document = REXML::Document.new(xml)
  
  # Use XPath to find the interesting parts of the data structure.
  REXML::XPath.each(document, '/ResultSet/Result/Title/[]') do |title|
    puts title
  end        
end

(puts "Usage: #{$0} [search term]"; exit) if ARGV.empty?
print_page_titles(ARGV.join(' '))    