require 'socket'
a = TCPServer.new('', 5950) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
loop {
  connection = a.accept
  text =  connection.recv(1024)
  puts "received:" + text
  File.open('data.txt', 'w') { |file| file.write(text) }
  connection.write "Message Recieved"
  connection.close
}