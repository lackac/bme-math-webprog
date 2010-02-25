def section(title)
  puts; puts; puts title; puts '=' * title.length
end

def subsection(title)
  puts; puts; puts title; puts
end

section "Viccmesélős"

# require File.expand_path('../gyakorlat-03/joke', File.dirname(__FILE__))
#
# puts Joke.random
# scores = ['Not funny at all', 'Sort of funny', 'Just humorous', 'Funny but not "LOL"', 'Genuinley funny', '"LOL"', 'Very funny', 'Mockingly funny']
# print "Na nevess! "
# while $1.nil?
#   if gets.chomp =~ /\bh[aei]((?:h[aei])*h?)\b/
#     if $1.length >= scores.length
#       puts scores.last
#     else
#       puts scores[$1.length]
#     end
#   else
#     print "Na nevess már! "
#   end
# end

section "A walesi bárdok"

require 'open-uri'

bardok = open("http://webprog.lackac.hu/file/gyakorlat-02/walesi_bardok.txt").read

section "nagybetűs szavak"
puts bardok.scan(/\b[A-Z]\S*/).sort.uniq.join(", ")

subsection "pontosabb, szebb megoldás"
puts bardok.scan(/\b[A-ZÁÉÍÓÖŐÚÜŰ][a-záéíóöőúüű]*/u).sort.uniq.join(", ")

# subsection "pontosabb megoldás lenne, csak nem működik"
#puts bardok.scan(/\b[[:upper:]][[:alpha:]]*/u).uniq.join(", ")

section "a költemény születésének éve"
puts bardok.scan(/\d{4}/)

section "s betűvel kezdődő sorok"
puts bardok.scan(/^[Ss][^z].*/).join("\n")

section "alliterációk"
bardok.scan(/\b(([a-záéíóöőúüű])[a-záéíóöőúüű]*)\b((?:\s+\2[a-záéíóöőúüű]*)+)(?:\s|$)/ui).each do |captures|
  first, _, rest = captures
  puts first + rest
end

section "versszakok"
verses = bardok.split(/\n\n/).select {|v| v.scan(/\n/).size == 3}
p verses

section "tokaji bárdok"
tokaji = bardok.sub("walesi", "tokaji").gsub(/velszi?/) do |match|
  match =~ /i$/ ? "tokaji" : "tokaj"
end
puts tokaji
