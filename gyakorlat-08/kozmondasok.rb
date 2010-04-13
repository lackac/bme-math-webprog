require 'rubygems'
require 'nokogiri'
require 'open-uri'

uri = "http://hu.wikiquote.org/wiki/Magyar_k%C3%B6zmond%C3%A1sok"
doc = Nokogiri::HTML(open(uri), uri, 'utf-8')

File.open("kozmondasok.txt", "w") do |f|
  doc.css("p > b").each do |km|
    f.puts km.text
  end
end
