require 'rubygems'
require 'bundler'

Bundler.require

$stdout.sync = true

require './wpoint'
run Sinatra::Application
