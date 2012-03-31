class Hotspot
  include Mongoid::Document
  include Mongoid::Timestamps

  # There's a bug in mongoid_spacial, remove silencer when fix is out
  ActiveSupport::Deprecation.silence do
    include Mongoid::Spacial::Document
  end

  field :bssid,     type: String
  field :ssid,      type: String
  field :location,  type: Array,    spacial: true
  field :open,      type: Boolean

  spacial_index :location
end
