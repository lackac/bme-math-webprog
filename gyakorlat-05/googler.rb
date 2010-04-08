require 'sinatra/base'
require 'nokogiri'
require 'uri'
require 'open-uri'

module WebProg
  class Gyakorlat05 < Sinatra::Base
    get '/search/:query' do
      html = "<pre>"
      doc = Nokogiri::HTML(open("http://www.google.com/search?q=#{URI.encode(%{"#{params[:query]}"})}"))
      doc.css(".g").each do |hit|
        link = hit.at_css("h3 a")
        if summary = hit.at_css(".s") and summary.child.name != "table"
          html << link.content << "\n"
          html << %{<a href="#{link['href']}">#{link['href']}</a>} << "\n"
          summary.css("div", "cite", ".gl").remove
          html << summary.content << "\n\n"
        end
      end
      html << "</pre>"
    end
  end
end
