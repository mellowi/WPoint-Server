if ENV['RACK_ENV'] == "production"
  worker_processes  4
else
  listen            3000
  worker_processes  1
end

preload_app true
timeout 30
