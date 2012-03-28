require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    "#{ENV.inspect}"
  end

end
