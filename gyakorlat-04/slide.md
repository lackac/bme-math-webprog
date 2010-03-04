!SLIDE center
## Ruby és webprogramozás
## 04 – **Nokogiri 鋸** (folytatás)

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center
# Hasznos metódusok

    @@@ ruby
    # sokszor tudjuk, hogy valamiből csak egy van
    # ilyenkor hasznos az #at_css és #at_xpath
    doc.at_css(".ip").text # => "80.98.236.148"
    doc.at_xpath("//*[@class='ip']").text # => "80.98.236.148"
    
    # de mit is adnak ezek a metódusok vissza
    doc.css(".ip").class # => Nokogiri::XML::NodeSet
    doc.at_css(".ip").class # => Nokogiri::XML::Element

    # Nokogiri::XML::NodeSet olyan, mint egy tömb
    # Nokogiri::XML::Node példányokat tartalmaz
    all_elems = doc.css("*")
    all_elems.size # => 17
    all_elems.map {|e| e.name}
      # ["html", "head", "title", ..., "a", "img"]

#### [Nokogiri::XML::NodeSet dokumentáció](http://nokogiri.org/Nokogiri/XML/NodeSet.html)

!SLIDE center
# Nokogiri::XML::Node

    @@@ ruby
    doc = Nokogiri::HTML(open("http://twitter.com/kelt/status/996180950"))
    elem = doc.at_css(".entry-content")
    elem.class.superclass # => Nokogiri::XML::Node

    # az elem neve (típusa)
    elem.name # => "span"

    # attribútumok hash-szerűen érhetők el
    elem['class'] # => "entry-content"

    # az elem tartalma
    elem.content # => "@longhand: annyi mindent hazudtak...
    # erre alias a #text és #inner_text

    # az elem html kódja
    elem.to_html # => "<span class="entry-content">@<a class=...

!SLIDE center
# Vándorlás a fában

    @@@ ruby
    # szülő node
    elem.parent.to_html # => "<span class="status-body">...

    # gyerekek
    elem.children.size # => 3
    # az első child node
    child = elem.child # => #<Nokogiri::XML::Text:0x952568 "@">

    # következő szomszédos node
    child.next.to_html # => "<a class="tweet-url username"...

    # előző szomszédos node
    child.previous # => nil
    child.next.previous == child # => true

    # ha nem kellenek a text node-ok akkor használhatjuk a
    # #previous_element és #next_element metódusokat

!SLIDE center
# Keresés node-ból indulva

    @@@ ruby
    # használhatók a #css, #at_css, #xpath, #at_xpath metódusok
    elem.at_css("a") == child.next # => true
    # vagy ezek általános párjai a #search és #at metódusok
    # ezek fogadnak css és xpath selectort is

    # ha kellene az egész dokumentumban a node-hoz vezető út
    elem.path
      # "/html/body/div[2]/div[3]/div/div/div[1]/span/span[1]"

    # a #traverse metódussal az elemen és gyerekein iterálhatunk
    elem.traverse {|n| puts n.path}

#### [Nokogiri::XML::Node dokumentáció](http://nokogiri.org/Nokogiri/XML/Node.html)

!SLIDE smbullets
# Ha a forrás nehezen emészthető

### Böngésző pluginek

* [FireBug](http://getfirebug.com/)
* [DOM Inspector](https://addons.mozilla.org/hu/firefox/addon/6622/)

!SLIDE center
# Ha ezek nem segítenek

    @@@ ruby
    # Nokogirit megkérjük szépen, hogy szépítsen
    doc.to_xhtml(:indent => 2)

    # Sőt, írja is egyből fájlba
    File.new("tweet.html", "w") do |f|
      doc.write_xhtml_to(f, :indent => 2)
    end

!SLIDE center commandline
# Feladat
### Írj egy programot, ami bekéri a felhasználó nevét, rákeres Google segítségével, és kiírja szépen a találatokat.

    @@@
    $ ruby googler.rb
    Mi a neved? Ruby
    Ruby Programming Language
    http://www.ruby-lang.org/
    10 Jan 2010 ... A dynamic, interpreted, open source programming language with a focus on simplicity and productivity. Site includes news, downloads, ...

    Download Ruby
    http://www.ruby-lang.org/en/downloads/
    Here you can get the latest Ruby distributions in your favorite flavor. The current stable  version is 1.9.1. Please be sure to read Ruby's License. ...

#### (következő slide-on néhány tipp)

!SLIDE center
# Néhány tipp

    @@@ ruby
    # google kereséshez url
    uri = "http://www.google.com/search?q="

    # url query string kódolás
    require 'uri'
    uri += URI.encode('"árvíztűrő tükörfúrógép"')
    uri # => "http://www.google.com/search?q=%22%C3%A1rv%C3%ADzt%C5%B1r%C5%91%20t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p%22"


!SLIDE smbullets
# Hasznos linkek

* [Nokogiri::XML::NodeSet](http://nokogiri.org/Nokogiri/XML/NodeSet.html)
* [Nokogiri::XML::Node](http://nokogiri.org/Nokogiri/XML/Node.html)
* Ruby Essentials on Teach Me To Code:
  <br/>[Strings, Arrays, Hashes](http://www.teachmetocenter.com/screencasts/35)
  <br/>[Blocks](http://www.teachmetocenter.com/screencasts/ruby-essentials-blocks)
