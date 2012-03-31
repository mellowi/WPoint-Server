class Hotspot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Spacial::Document

  field :bssid,     type: String
  field :ssid,      type: String
  field :location,  type: Array,    spacial: true
  field :open,      type: Boolean

  spacial_index :location
end
