Dir["./models/*.rb"].each {|file| require file }
Dir["./controllers/**/*_controller.rb"].each { |file| require file }


class WPoint < Sinatra::Base

  # --- settings for environments -------------------------
  FileUtils.mkdir("log")  unless File.exists?("log")

  configure :development do
    register Sinatra::Reloader
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

end
