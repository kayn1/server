# frozen_string_literal: true

# Client
class Client
  def self.start
    socket = TCPSocket.new 'localhost', 3000
    puts "Client started \u{1f916}"

    while line = socket.gets
      puts line
    end

    puts "Client closed \u{1f44B}"
    socket.close
  end
end
