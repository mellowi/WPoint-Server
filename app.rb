require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'mongoid'

Mongoid.load!("config/mongoid.yml")


class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    "#{ENV.inspect}"
  end

end
