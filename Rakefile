require 'rspec/core/rake_task'
require 'bundler'
Bundler.require

ENV['RACK_ENV'] = "development"  unless ENV['RACK_ENV']

task :default => :spec


desc "Run RSpec specs"
task :spec do
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--colour", "--format progress", "--require ./spec/spec_helper.rb"]
    t.pattern    = 'spec/**/*_spec.rb'
  end
end


desc "Clear the DB"
namespace :db do
  task :drop do
    Mongoid.load!("config/mongoid.yml")
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
    DatabaseCleaner.clean
  end
end


desc "Clears the DB and generates some random data"
task :test_data do
  Dir["./models/*.rb"].each {|file| require file }

  # Helper methods
  def random_within(range)
    Random.new.rand(range)
  end

  def mac_address
    (("%02x" % (rand(64) * 4 | 2)) + (0..4).inject("") {
      |s,x| s + ":%02x" % rand(256)
    }).upcase
  end

  def ssid
    "#{Faker::Lorem.words(1).first.capitalize}#{random_within(0..9)}"
  end


  # Logic starts here -->
  Mongoid.load!("config/mongoid.yml")
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.orm = "mongoid"
  DatabaseCleaner.clean

  ### Reports
  20.times do
    # Fake observation location
    user_latitude  = random_within(-90..90)
    user_longitude = random_within(-180..180)

    # Fake detected spots at observation location
    10.times do
      r = Report.new(
                     bssid:     mac_address,
                     ssid:      ssid,
                     latitude:  user_latitude + random_within(-0.01..0.01),
                     longitude: user_longitude + random_within(-0.01..0.01),
                     dbm:       random_within(-70..0),
                     open:      random_within(0..1)
                    )
      r.save!  rescue "Error: #{r.errors.full_messages.join(', ')}"
    end
  end

  ### HOTSPOTS
  # Todo: Remove, when there's an algorithm to calculate these
  100.times do
    h = Hotspot.new(
                   bssid:     mac_address,
                   ssid:      ssid,
                   location: {
                      lat:    62 + random_within(-0.01..0.01),
                      lon:    26 + random_within(-0.01..0.01)
                   },
                   open:      random_within(0..1)
                  )
    h.save!  rescue "Error: #{h.errors.full_messages.join(', ')}"
  end

  puts "-" * 80
  puts "Done. Database now contains #{Report.count} reports and #{Hotspot.count} hotspots."
end
