require 'rubygems'
require 'sinatra'

get '/hi' do
  "Hello World!"
end

get '/' do
  "<pre>#{params.inspect}</pre>"
end

get '/hi/:name' do
  "Hello #{params[:name]}"
end
