# frozen_string_literal: true

require 'socket'
require 'rack'

# Server
class Server
  Counter = Struct.new(:counter)
  trap('INT') { puts 'Exiting'; exit }

  def self.start
    puts "Server started \u{1f308} \u{1f4AA}"

    server = TCPServer.new 3000
    counter = 0
    app = proc { ['200', { 'Content-Type' => 'text/html' }, ['Hola!']] }

    response = Rack::Response.new("Response: #{counter}", 200, { 'Content-Type' => 'text/html' })

    loop do
      Thread.start(server.accept) do |client|
        counter += 1
        status, headers, body = app.call
        client.puts "Connection established! \u{1f680}"
        puts "There were #{counter} connections"
        client.print "HTTP/1.1 #{status} OK\r\n"
        headers.each { |k, v| client.print("#{k}: #{v}\r\n") }
        client.print "\r\n"
        body.each { |text| client.print text }
        client.close
      end
    end
  end
end
