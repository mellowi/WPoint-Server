# EXAMPLE: curl http://localhost:5000/api/v1/spots.json?latitude=62&longitude=26

class WPoint < Sinatra::Base

  DEFAULT_RADIUS_IN_METERS = 200

  get '/api/v1/spots.json' do
    content_type :json
    params[:radius] ||= DEFAULT_RADIUS_IN_METERS

    results = Hotspot.where(
      :location.near(:sphere) => {
        point: [params[:longitude], params[:latitude]],
        max:   params[:radius],
        unit:  :m
      }
    )

  halt 200, results.to_json
  end
end
