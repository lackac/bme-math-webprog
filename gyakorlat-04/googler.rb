require 'rubygems'
require 'nokogiri'
require 'uri'
require 'open-uri'

print "Mi a neved? "
query = gets.chomp

uri = "http://www.google.com/search?q=#{URI.encode(%{"#{query}"})}"
# puts uri

doc = Nokogiri::HTML(open(uri))
# puts doc.to_xhtml(:indent => 2)
# File.open("page.html", "w") {|f| doc.write_xhtml_to(f, :indent => 2)}

doc.css(".g").each do |hit|
  link = hit.at_css("h3 a")

  if summary = hit.at_css(".s") and summary.child.name != "table"
    puts link.content
    puts link['href']
    summary.css("div", "cite", ".gl").remove
    puts summary.content
    puts
  end
end
