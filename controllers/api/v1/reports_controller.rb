before_only(['/api/v1/report.*']) do
  content_type :json

  errors = []
  errors << "No JSON data given."  unless params[:data]
  halt 400, {"message" => errors}.to_json  unless errors.empty?
end


post '/api/v1/report.json' do
  begin
    data = JSON.parse(params[:data])
  rescue Exception => e
    error_message = "Parsing sent JSON failed: #{ex.message}."
    $log.error "[ERROR] POST/report.json: #{error_message}"
    halt 500, {"message" => error_message}.to_json
  end

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
    error_message = "Saving report to database failed: #{ex.message}."
    $log.error "[ERROR] POST/report.json: #{error_message}"
    halt 500, {"message" => error_message}.to_json
  end

  halt 201, {"message" => "Report stored."}.to_json
end
