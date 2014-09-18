# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
run PrivatePub.faye_app
run Rails.application
