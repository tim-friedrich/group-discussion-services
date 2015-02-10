require 'erb'

base_path = Rails.root.join("config")
File.write(
  base_path + "private_pub.yml",
  ERB.new(File.read(base_path + "private_pub.yml.erb")).result
)
