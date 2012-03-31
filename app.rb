require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'mongoid'
require 'mongoid_spacial'
Dir["./models/*.rb"].each {|file| require file }


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


  get '/spots' do
  end


  post '/report' do
  end

end
