require 'erb'

base_path = File.dirname(__FILE__) + '/../'
File.write(
  base_path + "private_pub.yml",
  ERB.new(File.read(base_path + "private_pub.yml.erb")).result
)
