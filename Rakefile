require 'rspec/core/rake_task'
require 'bundler'
Bundler.require

ENV['RACK_ENV'] = "development"  unless ENV['RACK_ENV']

task :default => :console


desc "Run RSpec specs"
task :spec do
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--colour", "--format progress", "--require ./spec/spec_helper.rb"]
    t.pattern    = 'spec/**/*_spec.rb'
  end
end


desc "Console"
task :console do
  Dir["./models/*.rb"].each {|file| require file }
  Mongoid.load!("config/mongoid.yml")
  require 'irb'
  IRB.start
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
    "#{Faker::Lorem.words(1).first.capitalize}"
  end


  # Logic starts here
  Mongoid.load!("config/mongoid.yml")
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.orm = "mongoid"
  DatabaseCleaner.clean


  # Number of different access points
  10.times do 
    ap_bssid = mac_address
    ap_ssid  = ssid
    is_open  = random_within(0..1)

    ### Number of observation points
    30.times do
      user_latitude  = 62 + random_within(-0.01..0.01)
      user_longitude = 26 + random_within(-0.01..0.01)

      r = Report.new(bssid:     ap_bssid,
                     ssid:      ap_ssid,
                     latitude:  user_latitude,
                     longitude: user_longitude,
                     dbm:       random_within(-30..0),
                     open:      is_open)
      r.save!  rescue "Error: #{r.errors.full_messages.join(', ')}"
    end
  end

  puts "(!) Database now contains #{Report.count} reports and #{Hotspot.count} hotspots."
end
