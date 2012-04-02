# EXAMPLE: curl -X POST -F "data=@test_reports.json" http://localhost:5000/api/v1/report.json

class WPoint < Sinatra::Base
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

    halt 201, {"message" => "Reports created."}.to_json
  end
end
