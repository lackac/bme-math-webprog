require 'open-uri'
html = open('http://ipcimed.hu/')
html.class # => StringIO
html = html.read

require 'rubygems'
require 'nokogiri'
doc = Nokogiri::HTML(html)
doc.css(".ip").first.text # => "80.98.236.148"
doc.xpath("//*[@class='ip']") \
   .first.text # => "80.98.236.148"
