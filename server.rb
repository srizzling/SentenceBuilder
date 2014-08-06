require 'socket'
path = 'data.txt'
a = TCPServer.new('', 5950) # '' means to bind to "all interfaces", same as nil or '0.0.0.0'
loop {
  connection = a.accept
  text =  connection.recv(200000000)
  puts "received:" + text
  File.open(path, 'w') { |file| file.write(text) }
  connection.write "Sriram has recieved your message"
  connection.close
}