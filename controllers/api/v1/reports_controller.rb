before_only(['/api/v1/report.*']) do
  content_type :json

  errors = []
  errors << "File not uploaded."  unless params[:data]
  halt 400, {"message" => errors}.to_json  unless errors.empty?
end


# EXAMPLE: curl -X POST -F "data={payload}" http://localhost:5000/api/v1/report.json
post '/api/v1/report.json' do
  data = JSON.parse(params[:data])

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
