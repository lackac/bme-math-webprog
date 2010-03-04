!SLIDE center
## Ruby és webprogramozás
## 03 – **Nokogiri 鋸**

### **Bácsi László a.k.a. *LacKac***
### [lackac.hu](http://lackac.hu) lackac@lackac.hu

!SLIDE center
# Weboldal letöltés

    @@@ ruby
    require 'open-uri'
    html = open('http://ipcimed.hu/')
    html.class # => StringIO
    html = html.read

#### [nyitsd meg böngészőben](http://ipcimed.hu/), és "view source"

!SLIDE center
# Nokogiri alapok

    @@@ ruby
    require 'rubygems'
    require 'nokogiri'
    doc = Nokogiri::HTML(html)
    doc.css(".ip").first.text # => "80.98.236.148"
    doc.xpath("//*[@class='ip']").first.text # => "80.98.236.148"

!SLIDE center smaller

# CSS vs. XPath

    | Cél                   | CSS 3             | XPath                       |
    | Minden elem           | *                 | //*                         |
    | Minden P elem         | p                 | //p                         |
    | Minden gyereke        | p > *             | //p/*                       |
    | Minden leszármazott   | p *               | //p//*                      |
    | ID alapján            | #foo              | //*[@id='foo']              |
    | Class alapján         | .foo              | //*[contains(@class,'foo')] |
    | Elem title-el         | *[title]          | //*[@title]                 |
    | Minden P első gyereke | p > *:first-child | //p/*[0]                    |
    | Minden P A gyerekkel  | Not possible      | //p[a]                      |
    | P után következő elem | p + *             | //p/following-sibling::*[0] |

!SLIDE center smbullets
# Feladatok
### Szedd ki az alábbi oldalak valamelyikéből a "tartalmat"

* [http://milyennap.wamma.hu/](http://milyennap.wamma.hu/)
* [http://mavsztrajk-e.wamma.hu/](http://mavsztrajk-e.wamma.hu/)
* [http://twitter.com/kelt/status/996180950](http://twitter.com/kelt/status/996180950)<br/>vagy akármilyen másik twitter status permalink

!SLIDE center smbullets
# Feladatok
### Szedd ki az oldalból az Euró, az Amerikai Dollár és a Svácji Frank aktuális árfolyamát

* [http://xurrency.com/huf](http://xurrency.com/huf)

!SLIDE center smbullets
# Feladatok
### Írass ki egy véletlenszerűen választott viccet az alábbi oldalról:

* [http://viccek.w3w.hu/matematikai-viccek.html](http://viccek.w3w.hu/matematikai-viccek.html)

!SLIDE smbullets
# Hasznos linkek

* **Nokogiri**:
[http://nokogiri.org/](http://nokogiri.org/)
* [XPath syntax](http://www.w3schools.com/XPath/xpath_syntax.asp)
* [CSS selectors](https://developer.mozilla.org/en/CSS_Reference#Selectors)
* Ha több kell: **[Mechanize](http://mechanize.rubyforge.org/mechanize/)**
