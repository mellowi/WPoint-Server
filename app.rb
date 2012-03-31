Dir["./models/*.rb"].each {|file| require file }


class App < Sinatra::Base

  DEFAULT_RADIUS_IN_METERS = 1000

  # --- settings for environments -------------------------
  FileUtils.mkdir("log")  unless File.exists?("log")

  configure :development do
    register Sinatra::Reloader
    Mongoid.logger = Logger.new("log/development.log")
    Mongoid.logger.level = Logger::DEBUG
  end

  configure :production do
    Mongoid.logger = Logger.new("log/production.log")
    Mongoid.logger.level = Logger::ERROR
  end


  # --- connect to DB -------------------------------------
  Mongoid.load!("config/mongoid.yml")


  # --- actions -------------------------------------------
  get '/' do
    "Try /spots or /report"
  end

  get '/spots' do
    params[:radius] ||= DEFAULT_RADIUS_IN_METERS

    result = Hotspot.where(
      :location.near(:sphere) => {
        point: [params[:longitude], params[:latitude]],
        max:   params[:radius],
        unit:  :m
      }
    ).entries

    result.to_json
  end

  post '/report' do
    # todo
  end

end
