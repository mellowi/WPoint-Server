require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'mongoid'
require 'mongoid_spacial'

require './models/hotspot'
require './models/report'




class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    Mongoid.logger = Logger.new("log/development.log")
    Mongoid.logger.level = Logger::DEBUG
  end

  configure :production do
    Mongoid.logger = Logger.new("log/production.log")
    Mongoid.logger.level = Logger::ERROR
  end

  Mongoid.load!("config/mongoid.yml")


  get '/' do
    "Download file"
  end


  post '/' do
    "Upload file"
  end

end
