require 'rspec/core/rake_task'

task :default => :spec

desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--colour", "--format progress", "--require ./spec/spec_helper.rb"]
    t.pattern    = 'spec/**/*_spec.rb'
  end
end
