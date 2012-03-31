require 'rspec/core/rake_task'

task :default => :spec

task :spec do
  RSpec::Core::RakeTask.new do |task|
    task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
    task.pattern    = 'spec/**/*_spec.rb'
  end
end
