class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  validates_presence_of :bssid
  validates_presence_of :ssid
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :dbm
  validates_presence_of :open

  validates_format_of :bssid, with: /^([0-9a-f]{2}[:-]){5}([0-9a-f]{2})$/i
  validates_length_of :ssid, within: 1..32

  validates_numericality_of :latitude,
                             greater_than_or_equal_to: -90,
                             less_than_or_equal_to: 90

  validates_numericality_of :longitude,
                             greater_than_or_equal_to: -180,
                             less_than_or_equal_to: 180

  validates_numericality_of :signal,
                             greater_than_or_equal_to: -70,
                             less_than_or_equal_to: 0

  field :bssid,       type: String
  field :ssid,        type: String
  field :latitude,    type: Float
  field :longitude,   type: Float
  field :dbm,         type: Integer
  field :open,        type: Boolean
end
