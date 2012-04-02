class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  # Callbacks
  after_create :calculate_hotspot_location

  # Validations (remove when optimizations are topical)
  validates_presence_of :bssid
  validates_presence_of :ssid
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :dbm

  validates_format_of :bssid, with: /^([0-9a-f]{2}[:-]){5}([0-9a-f]{2})$/i
  validates_length_of :ssid, within: 1..32

  validates_numericality_of :dbm,
                             greater_than_or_equal_to: -30,
                             less_than_or_equal_to: 0

  validates_numericality_of :latitude,
                             greater_than_or_equal_to: -90,
                             less_than_or_equal_to: 90

  validates_numericality_of :longitude,
                             greater_than_or_equal_to: -180,
                             less_than_or_equal_to: 180

  # Fields
  field :bssid,     type: String
  field :ssid,      type: String
  field :latitude,  type: Float
  field :longitude, type: Float
  field :dbm,       type: Integer
  field :open,      type: Boolean

   # Indices
  index([
    [:bssid, Mongo::ASCENDING],
    [:ssid,  Mongo::ASCENDING]
  ])


  private

    # TODO: What to do if there are several different hotspots
    # with BOTH same bssid and ssid? Take also location into account?
    def calculate_hotspot_location
      longitude_sum = 0
      latitude_sum  = 0
      report_count  = 0

      # TODO: Calculate only from N latest observations
      # TODO: Take signal strenght into account
      Report.where(bssid: self.bssid, ssid: self.ssid).each do |report|
        longitude_sum = longitude_sum + report.longitude
        latitude_sum  = latitude_sum  + report.latitude
        report_count  = report_count + 1
      end

      estimated_longitude = longitude_sum / report_count
      estimated_latitude  = latitude_sum  / report_count

      h = Hotspot.find_or_initialize_by(:bssid => self.bssid,
                                        :ssid  => self.ssid)
      h.location = [estimated_longitude, estimated_latitude]
      h.open     = self.open  # always store the latest status
      h.save!
    end
end
