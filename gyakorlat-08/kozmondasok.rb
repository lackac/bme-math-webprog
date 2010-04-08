require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://hu.wikiquote.org/wiki/Magyar_k%C3%B6zmond%C3%A1sok"))

File.open("kozmondasok.txt", "w") do |f|
  doc.css("p > b").each do |km|
    f.puts km.text
  end
end
