require 'rubygems'
require 'sinatra/base'


class App < Sinatra::Base

  get '/' do
    "Environment is: #{ENV['RACK_ENV']}"
  end

end
