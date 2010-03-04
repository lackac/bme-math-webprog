require 'rubygems'
require 'nokogiri'
require 'open-uri'

# EUR, USD és CHF árfolyamok
doc = Nokogiri::HTML(open("http://xurrency.com/huf"))
# az összes árfolyamot fogja tartalmazni két elemű tömbök tömbjeként
rates = doc.css("td.camb").map do |td|
  # kiszedi a valutanemet és a forintban vett árfolyamát egy kételemű tömbbe
  td.text.scan(/1 ([A-Z]+) = ([\d\.]+) HUF/)
end
# a tömböt "kilapítja" és egy hasht készít belőle
rates = Hash[*rates.flatten]
# kiírja a kért árfolyamokat
%w{EUR USD CHF}.each do |v|
  puts "#{v}: #{rates[v]}"
end
