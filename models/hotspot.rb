class Hotspot
  include Mongoid::Document
  include Mongoid::Timestamps

  ActiveSupport::Deprecation.silence do
    include Mongoid::Spacial::Document
  end

  # Validations (remove when optimizations are topical)
  validates_presence_of :bssid
  validates_presence_of :ssid
  validates_presence_of :location

  validates_format_of :bssid, with: /^([0-9a-f]{2}[:-]){5}([0-9a-f]{2})$/i
  validates_length_of :ssid, within: 1..32

  # Fields
  field :bssid,     type: String
  field :ssid,      type: String
  field :location,  type: Array,    spacial: true
  field :open,      type: Boolean

  # Indices
  spacial_index :location
end
