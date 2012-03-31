if ENV['RACK_ENV'] == "production"
  listen            ENV['PORT']  # set by Heroku
  worker_processes  4
else
  listen            3000
end

preload_app true
timeout 30
