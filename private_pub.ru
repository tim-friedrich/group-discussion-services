# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
PrivatePub.faye_app.get_client.set_header 'Authorization', 'Basic Z2RzOmthZmZlZQ==' # TODO remove when no more basic auth
run PrivatePub.faye_app
