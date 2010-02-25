"Piros Alma" =~ /alma/i   # => 6

"piros bicikli" =~ /alma/ # => nil

# print "Email: "
# email = gets.chomp
# if email =~ /\w+@(\w+\.)+\w+/
#   puts "Helyes email cím"
# else
#   puts "Ez biztos nem jó email cím"
# end

# Speciális karakterek
# . [ ] | ( ) * + ? { } ^ $ \

# . minden karakterre illeszkedik
"BME" =~ /BM./        # => 0
# [ ] minden karakterre, amit tartalmaz
"BMF" =~ /BM[EF]/     # => 0
# [^ ] vagy amit nem tartalmaz
"BMF" =~ /BM[^E]/     # => 0
# lehet benne range is
"BME" =~ /B[A-Z][^a-z]/ # => 0

# | vagy kapcsolat
"ELTE" =~ /BME|ELTE/  # => 0

# ( ) csoportosítás
"egyetem: BME" =~ /(egyetem|főiskola): ([A-Z]+)/ # => 0

# a zárójeles részeket "elkapja"
$1 # => "egyetem"
$2 # => "BME"

# * előző atom akárhányszor
"hmmm" =~ /hm*/         # => 0
"hehehe" =~ /(h[aei])*/ # => 0

# + előző atom legalább egyszer
"" =~ /(h[aei])*/       # => 0
"" =~ /(h[aei])+/       # => nil
"hehehe" =~ /(h[aei])+/ # => 0

# alapból ezek greedy-k, de ezen ? változtat
"said hmmm" =~ /(hm+)/; $1   # => "hmmm"
"said hmmm" =~ /(hm+?)/; $1  # => "hm"

# ? előző atom legfeljebb egyszer
"egyetem BME" =~ /egyetem:? BME/ # => 0

# {n} pontosan n-szer
"hmmm" =~ /hm{3}/   # => 0
# {n,m} legalább n-szer, de legfeljebb m-szer
"hmmm" =~ /hm{2,4}/ # => 0

# ez is alapból greedy
"hmmmmm" =~ /hm{2,4}/; $&   # => "hmmmm"
"hmmmmm" =~ /hm{2,4}?/; $&  # => "hmm"

shopping_list = <<EOS
Bevásárló lista:
1 db nyúl
25 db tojás ✓
42 db 1 éves bárány
EOS

# ^ sor elejére, $ sor végére illeszkedik
shopping_list.scan(/^\d+ .*$/)
  # ["1 db nyúl", "25 db tojás ✓", "42 db 1 éves bárány"]
shopping_list.scan(/^.* ✓$/)
  # ["25 db tojás ✓"]


# \A, \z, \Z  string eleje, vége,
# vagy vége de még newline előtt
"egy\nkettő\n" =~ /\A(.*?)\Z(.*?)\z/m
$~.captures # => ["egy\nkettő", "\n"]

# \b szóhatár, \B nem szóhatár
# \d számjegy (ugyanaz, mint [0-9])
# \s whitespace (ugyanaz, mint [ \t\n\r\f])
# \w szó karakter (ugyanaz, mint [0-9A-Za-z_])
# \D, \S, \W ezek ellentetjei

# \1-9 n. csoport találata
# \&   teljes találat
"person people rock member" =~ /\b(\w)\S*\1\S*\b/
$& # => "people"

# \`            pre-match
# \'            post-match
# \+            highest group matched
# (?#)          comment
# (?:)          grouping without backreferences
# (?=)          zero-width positive look-ahead assertion
# (?!)          zero-width negative look-ahead assertion
# (?>)          nested anchored sub-regexp. stops backtracking.
# (?imx-imx)    turns on/off imx options for rest of regexp.
# (?imx-imx:re) turns on/off imx options, localized in group.

# .sub első találatot cseréli
"lackac@lackac.hu".sub(/@/, ' alma ') # => "lackac alma lackac.hu"
# .gsub az összes találatot cseréli
"hahaha hehehe".gsub(/h[ae]/, 'hi') # => "hihihi hihihi"

# van felkiáltójeles változatuk is
email = "lackac@lackac.hu"; email.gsub!(/@/, '!')
email # => "lackac!lackac.hu"

# block-ot is képesek fogadni, ilyenkor a block
# megkapja az illeszkedő sztringet és a block
# visszatérési értéke lesz a csere
emails = "lackac@lackac.hu lackac@math.bme.hu"
emails.gsub(/\w+@([\w.]+)/) { $1 }
  # "lackac.hu math.bme.hu"

"kics nagy".sub(/n[^ ]+/) {|m| m.upcase}
  # "kics NAGY"

# .scan kiszedi az összes illeszkedő sztringet
"egy gyáva madárijesztő vágya".scan(/\S*gy\S*/)
  # ["egy", "gyáva", "vágya"]

# ha van benne capture, akkor azokat adja vissza
shopping_list.scan(/^(\d+) .*$/)
  # [["1"], ["25"], ["42"]]

# .split regexpek mentén darabol sztringet
"Alice Bob,Carol, Dave".split(/[, ]+/)
  # ["Alice", "Bob", "Carol", "Dave"]
