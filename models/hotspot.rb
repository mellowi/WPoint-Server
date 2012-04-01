class Hotspot
  include Mongoid::Document
  include Mongoid::Timestamps

  ActiveSupport::Deprecation.silence do
    include Mongoid::Spacial::Document
  end


  # Fields
  field :bssid,     type: String
  field :ssid,      type: String
  field :location,  type: Array,    spacial: true
  field :open,      type: Boolean

  # Indices
  spacial_index :location
end
