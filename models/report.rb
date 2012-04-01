class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  ActiveSupport::Deprecation.silence do
    include Mongoid::Spacial::Document
  end

  validates_presence_of :bssid
  validates_presence_of :ssid
  validates_presence_of :location
  validates_presence_of :dbm

  validates_format_of :bssid, with: /^([0-9a-f]{2}[:-]){5}([0-9a-f]{2})$/i
  validates_length_of :ssid, within: 1..32

  validates_numericality_of :dbm,
                             greater_than_or_equal_to: -70,
                             less_than_or_equal_to: 0

  field :bssid,     type: String
  field :ssid,      type: String
  field :location,  type: Array,    spacial: true
  field :dbm,       type: Integer
  field :open,      type: Boolean

  spacial_index :location
end
