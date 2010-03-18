require 'rubygems'
require 'sinatra'
require 'erb'

get "/" do
  erb :home
end

get "/hi/:name" do
  erb :hi
end

get "/erb_test" do
  erb :erb_test
end

get "/test" do
  params.inspect
end
