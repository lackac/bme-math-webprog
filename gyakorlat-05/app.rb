require 'sinatra/base'

module WebProg
  class Gyakorlat05 < Sinatra::Base
    set :root, File.dirname(__FILE__)
    helpers WebProg::Helpers

    get "/" do
      "<pre>#{params.inspect}</pre>" +
      %{<a href="slides">Slides</a>}
    end

    get '/hi' do
      "Hello World!"
    end

    get '/hi/:name' do
      "Hello #{params[:name]}"
    end
  end
end
