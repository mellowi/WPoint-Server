LIB_PATH         = './lib/**/*.rb'
MODELS_PATH      = './models/**/*.rb'
CONTROLLERS_PATH = './controllers/**/*_controller.rb'

Dir[LIB_PATH].each {|file| require file }
Dir[MODELS_PATH].each {|file| require file }
Dir[CONTROLLERS_PATH].each { |file| require file }


# --- settings for environments -------------------------
FileUtils.mkdir("log")  unless File.exists?("log")

configure :development do |config|
  require 'sinatra/reloader'
  config.also_reload LIB_PATH
  config.also_reload MODELS_PATH
  config.also_reload CONTROLLERS_PATH
  Mongoid.logger = Logger.new("log/development.log")
  Mongoid.logger.level = Logger::DEBUG
end

configure :production do
  Mongoid.logger = Logger.new("log/production.log")
  Mongoid.logger.level = Logger::ERROR
end


# --- connect to DB -------------------------------------
Mongoid.load!("config/mongoid.yml")
