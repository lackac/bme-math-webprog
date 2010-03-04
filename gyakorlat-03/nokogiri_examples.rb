require 'open-uri'
html = open('http://ipcimed.hu/')
html.class # StringIO
html = html.read

require 'rubygems'
require 'nokogiri'
doc = Nokogiri::HTML(html)
doc.css(".ip").first.text # "80.98.236.148"
doc.xpath("//*[@class='ip']").first.text # "80.98.236.148"
doc.at_css(".ip").text # "80.98.236.148"
doc.at_xpath("//*[@class='ip']").text # "80.98.236.148"

# doc = Nokogiri::HTML(open('http://twitter.com/kelt/status/996180950'))
# doc.at_css('.entry-content').text

doc.css("*").map {|e| e.name} # => ["html", "head", "title", "link", "style", "body", "p", "span", "p", "p", "br", "a", "p", "a", "img", "a", "img"]

all_elems = doc.css("*")
all_elems.size # => 17
all_elems.map {|e| e.name}
  # ["html", "head", "title", ..., "a", "img"]

doc = Nokogiri::HTML(open("http://twitter.com/kelt/status/996180950"))
elem = doc.at_css(".entry-content")
elem.class.superclass # => Nokogiri::XML::Node

# az elem neve (típusa)
elem.name # => "span"

# attribútumok hash-szerűen érhetők el
elem['class'] # => "entry-content"

# az elem tartalma
elem.content # => "@longhand: annyi mindent hazudtak nekünk, repülő autó, feszülősruha, pirulásebéd, legalább a vezetéknélküli kommunikáció legyen igaz :)"
# erre alias a #text és #inner_text

elem.to_html # => "<span class=\"entry-content\">@<a class=\"tweet-url username\" href=\"/longhand\" rel=\"nofollow\">longhand</a>: annyi mindent hazudtak nekünk, repülő autó, feszülősruha, pirulásebéd, legalább a vezetéknélküli kommunikáció legyen igaz :)</span>"

# szülő node
elem.parent.to_html # => "<span class=\"status-body\">\n            <span class=\"entry-content\">@<a class=\"tweet-url username\" href=\"/longhand\" rel=\"nofollow\">longhand</a>: annyi mindent hazudtak nekünk, repülő autó, feszülősruha, pirulásebéd, legalább a vezetéknélküli kommunikáció legyen igaz :)</span>\n    <a href=\"http://twitter.com/kelt/status/996180950\">...</a>    <span class=\"meta entry-meta\" data=\"{}\">\n  <a class=\"entry-date\" rel=\"bookmark\" href=\"http://twitter.com/kelt/status/996180950\">\n    <span class=\"published timestamp\" data=\"{time:'Sat Nov 08 10:09:13 +0000 2008'}\">2:09 AM Nov 8th, 2008</span>\n  </a>\n  <span>via <a href=\"http://turulcsirip.hu/\" rel=\"nofollow\">Turulcsirip</a></span>\n    \n  <a href=\"http://twitter.com/longhand/status/996179122\">in reply to longhand</a>  </span>\n\n    \n          </span>"

# gyerekek
elem.children.size # => 3
# az első child node
child = elem.child # => #<Nokogiri::XML::Text:0x9398ba "@">

# következő szomszédos node
child.next.to_html # => "<a class=\"tweet-url username\" href=\"/longhand\" rel=\"nofollow\">longhand</a>"

# előző szomszédos node
child.previous # => nil
child.next.previous == child # => true

# ha nem kellenek a text node-ok akkor használhatjuk a
# #previous_element és #next_element metódusokat

# használhatók a #css, #at_css, #xpath, #at_xpath metódusok
elem.at_css("a") == child.next # => true
# vagy ezek általános párjai a #search és #at metódusok
# ezek fogadnak css és xpath selectort is

# ha kellene az egész dokumentumban a node-hoz vezető út
elem.path # => "/html/body/div[2]/div[3]/div/div/div[1]/span/span[1]"

# a #traverse metódussal az elemen és gyerekein iterálhatunk
# elem.traverse {|n| puts n.path}

uri = "http://www.google.com/search?q="
uri += URI.encode('"árvíztűrő tükörfúrógép"')
uri # => "http://www.google.com/search?q=%22%C3%A1rv%C3%ADzt%C5%B1r%C5%91%20t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p%22"
