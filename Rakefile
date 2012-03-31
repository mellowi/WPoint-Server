require 'awesome_print'
require 'rspec/core/rake_task'

ENV['RACK_ENV'] = "development"  unless ENV['RACK_ENV']

task :default => :test_data

desc "Run RSpec specs"
task :spec do
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--colour", "--format progress", "--require ./spec/spec_helper.rb"]
    t.pattern    = 'spec/**/*_spec.rb'
  end
end


desc "Clears the db and generates some random data"
task :test_data do
  require 'mongoid'
  require 'mongoid_spacial'
  require 'database_cleaner'
  require 'faker'
  Dir["./models/*.rb"].each {|file| require file }


  # Helper methods
  def random(range)
    Random.new.rand(range)
  end

  def mac_address
    (("%02x" % (rand(64) * 4 | 2)) + (0..4).inject("") {
      |s,x| s + ":%02x" % rand(256)
    }).upcase
  end

  def ssid
    "#{Faker::Lorem.words(1).first.capitalize}#{random(0..9)}"
  end


  # Logic starts here -->
  Mongoid.load!("config/mongoid.yml")
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.orm = "mongoid"
  DatabaseCleaner.clean

  ### Reports
  20.times do
    user_latitude  = random(-90..90)
    user_longitude = random(-180..180)

    # Spots per observation location
    10.times do
      r = Report.new(
                     bssid:     mac_address,
                     ssid:      ssid,
                     latitude:  user_latitude + random(-0.10..0.10),
                     longitude: user_longitude + random(-0.10..0.10),
                     dbm:       random(-70..0),
                     open:      random(0..1)
                    )
      r.save!  rescue "Error: #{r.errors.full_messages.join(', ')}"
    end
  end

  ### HOTSPOTS
  100.times do
    h = Hotspot.new(
                   bssid:     mac_address,
                   ssid:      ssid,
                   location: {
                      latitude:  random(-90.0..90.0),
                      longitude: random(-180.0..180.0)
                   },
                   open:      random(0..1)
                  )
    h.save!  rescue "Error: #{h.errors.full_messages.join(', ')}"
  end

end
