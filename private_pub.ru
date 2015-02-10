# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require 'dotenv'
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')
load File.dirname(__FILE__) + '/config/initializers/private_pub_erb.rb'

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
PrivatePub.faye_app.get_client.set_header 'Authorization', 'Basic Z2RzOmthZmZlZQ==' # TODO remove when no more basic auth
run PrivatePub.faye_app
