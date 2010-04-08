require 'sinatra/base'
require 'erb'

module WebProg
  class Gyakorlat06 < Sinatra::Base
    set :root, File.dirname(__FILE__)
    helpers WebProg::Helpers

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
  end
end
