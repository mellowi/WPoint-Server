if ENV['RACK_ENV'] == "production"
  worker_processes 4
else
  worker_processes 1
end

preload_app true
timeout 30
