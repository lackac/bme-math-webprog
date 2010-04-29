require 'rubygems'
require 'sinatra'
require "showoff"
require 'webprog'

disable :run

set :environment, :development

map "/" do
  run ShowOff.new
end

slides = {
  '01' => '#1',  '02' => '#4',  '03' => '#20', '04' => '#28', '05' => '#38',
  '06' => '#47', '07' => '#54', '08' => '#80', '09' => '#95', '10' => '#115',
  '11' => '#127', '12' => '#131'
}

Dir["gyakorlat-*"].each do |dir|
  n = dir[/\d+/]
  if File.exists?(File.join(dir, "app.rb"))
    require File.join(dir, "app")
    klass = WebProg.const_get("Gyakorlat#{n}")
    klass.class_eval do
      get "" do
        redirect request.path+"/"
      end
      get "/slides/?" do
        redirect "/"+slides[n]
      end
    end
    map "/#{dir}" do
      run(klass)
    end
  else
    klass = Class.new(Sinatra::Base)
    WebProg.const_set("Gyakorlat#{n}", klass)
    klass.class_eval do
      get "/?" do
        redirect "/"+slides[n]
      end
    end
    map "/#{dir}" do
      run(klass)
    end
  end
end
