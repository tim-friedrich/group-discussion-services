# from http://stackoverflow.com/questions/517219/ruby-see-if-a-port-is-open
require 'paint'

def port_open?(ip, port, seconds=1)
  Timeout::timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end
  end
rescue Timeout::Error
  false
end

RSpec.configure do |config|
  config.before(:suite){
    unless port_open? "localhost", 9292
      warn Paint["Please start the WebSocket server on port 9292 before running the test suite", :red]
      exit(1)
    end
  }
end