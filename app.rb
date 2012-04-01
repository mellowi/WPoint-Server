Dir["./models/*.rb"].each {|file| require file }


class App < Sinatra::Base

  DEFAULT_RADIUS_IN_METERS = 200

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
    "GET /api/v1/spots or POST /api/v1/report"
  end


  # --- get hotspots
  # http://localhost:5000/api/v1/spots.json?latitude=62&longitude=26
  get '/api/v1/spots.json' do
    content_type :json
    params[:radius] ||= DEFAULT_RADIUS_IN_METERS

    results = Hotspot.where(
      :location.near(:sphere) => {
        point: [params[:longitude], params[:latitude]],
        max:   params[:radius],
        unit:  :m
      }
    ).entries

    halt 200, results.to_json
  end


  # --- report results
  # curl -X POST -F "data=@test_reports.json" http://localhost:5000/api/v1/report.json
  post '/api/v1/report.json' do
    content_type :json

    unless params[:data]
      halt 400, {"message" => "File not uploaded."}.to_json
    end

    data = JSON.parse(params[:data][:tempfile].read)

    begin
      data["results"].each do |report|
        Report.create!(bssid:     report["bssid"],
                       ssid:      report["ssid"],
                       latitude:  data["latitude"],
                       longitude: data["longitude"],
                       dbm:       report["dbm"],
                       open:      report["open"])
      end
    rescue StandardError => ex
      halt 500, {"message" => "Saving report failed: #{ex.message}."}.to_json
    end

    Report.where(:


    halt 201, {"message" => "Reports created."}.to_json
  end

end
