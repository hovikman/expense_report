#!/c/Ruby193/bin/ruby

require 'open-uri'
require 'rexml/document'

def get_exchange_rate(from_currency, to_currency)
  # Fetch a resource: an XML document with exchange rate.
  xml = open("http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate?FromCurrency=#{from_currency}&ToCurrency=#{to_currency}").read
  
  # Parse the XML document into a data structure.
  document = REXML::Document.new(xml)
  
  # Use XPath to find the interesting parts of the data structure.
  REXML::XPath.each(document, '//double') do |rate|
    puts rate[0]
  end        
end

# Main program.
if ARGV.size != 2
  puts "Usage: #{$0} [from_currency] [to_currency]"
  exit
end

from_currency, to_currency = ARGV
get_exchange_rate(from_currency, to_currency)    