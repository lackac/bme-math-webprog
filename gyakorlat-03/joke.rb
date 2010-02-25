require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'iconv'

module Joke
  def self.jokes
    @jokes ||= get_jokes
  end

  def self.get_jokes
    doc = Nokogiri::HTML(open("http://viccek.w3w.hu/matematikai-viccek.html"))
    doc.css('table.blog .Post').map do |post|
      title = post.css('h3').first.text.strip
      joke = post.css('.article > p').first.children.map do |elem|
        elem.text? ? elem.text.strip : elem.node_name == "br" ? "\n" : ""
      end.join
      Iconv.iconv('latin1', 'utf8', "# #{title}\n#{joke}")
    end
  end

  def self.random
    jokes[rand(jokes.size)]
  end
end

if __FILE__ == $PROGRAM_NAME
  puts Joke.random
end
