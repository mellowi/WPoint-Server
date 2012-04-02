require 'rubygems'
require 'bundler'

Bundler.require

require './wpoint'
run Sinatra::Application
