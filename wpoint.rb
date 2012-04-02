# http://blog.alastairdawson.com/2010/07/27/a-sinatra-before-only-filter/
module Sinatra
  module BeforeOnlyFilter
    def before_only(routes, &block)
      before do
        routes.map!{|x| x = x.gsub(/\*/, '\w+')}
        routes_regex = routes.map{|x| x = x.gsub(/\//, '\/')}
        instance_eval(&block) if routes_regex.any? {|route| (request.path =~ /^#{route}$/) != nil}
      end
    end
  end
  register BeforeOnlyFilter
end

MODELS_PATH      = "./models/*.rb"
CONTROLLERS_PATH = "./controllers/**/*_controller.rb"

Dir[MODELS_PATH].each {|file| require file }
Dir[CONTROLLERS_PATH].each { |file| require file }


configure :development do |config|
  require 'sinatra/reloader'
  config.also_reload MODELS_PATH
  config.also_reload CONTROLLERS_PATH
end

# --- settings for environments -------------------------
FileUtils.mkdir("log")  unless File.exists?("log")

configure :development do
  set :logging, true
  Mongoid.logger = Logger.new("log/development.log")
  Mongoid.logger.level = Logger::DEBUG
end

configure :production do
  Mongoid.logger = Logger.new("log/production.log")
  Mongoid.logger.level = Logger::ERROR
end

# --- connect to DB -------------------------------------
Mongoid.load!("config/mongoid.yml")


