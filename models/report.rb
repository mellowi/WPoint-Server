class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :bssid        type: String
  field :ssid,        type: String
  field :latitude,    type: Float
  field :longitude,   type: Float
  field :signal,      type: Integer
  field :open,        type: Boolean
end
