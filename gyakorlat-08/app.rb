require 'sinatra/base'
require 'erb'

module WebProg
  class Gyakorlat08 < Sinatra::Base
    set :root, File.dirname(__FILE__)
    helpers WebProg::Helpers

    enable :sessions

    get "/" do
      erb :home
    end

    post "/login" do
      if params[:user] == "LacKac" and params[:pass] == "jelszo"
        session[:logged_in] = true
        session[:notice] = "Sikeres bejelentkezés!"
        redirect path("/titkok")
      else
        session[:error] = "Hibás felhasználónév vagy jelszó"
        redirect path("/")
      end
    end

    get "/logout" do
      session[:logged_in] = nil
      session[:notice] = "Sikeres kijelentkezés!"
      redirect path("/")
    end

    get "/titkok" do
      if session[:logged_in]
        erb "<h2>A Yeti létezik!</h2>"
      else
        session[:error] = "Nem vagy bejelentkezve!"
        redirect path("/")
      end
    end
  end
end
