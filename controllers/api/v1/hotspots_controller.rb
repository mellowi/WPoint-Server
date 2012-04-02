before_only(['/api/v1/spots.*']) do
  content_type :json

  errors = []
  errors << "Latitude not given as parameter."     unless params[:latitude]
  errors << "Longitude not given as a parameter."  unless params[:longitude]
  halt 400, {"message" => errors}.to_json  unless errors.empty?
end


# EXAMPLE: curl http://localhost:5000/api/v1/spots.json?latitude=62&longitude=26
get '/api/v1/spots.json' do
  params[:radius] ||= 200  # in meters

  results = Hotspot.where(
    :location.near(:sphere) => {
      point: [params[:longitude], params[:latitude]],
      max:   params[:radius],
      unit:  :m
    }
  )

  halt 200, results.to_json
end
