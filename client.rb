require 'socket'
require 'yaml'

def find_dest
	name = ARGV[0]
	file_content= YAML.load_file("users.yml")
	file_content['users'][name]
end

def create_socket
	check_arg
	dest = find_dest
	a = TCPSocket.new(dest, 5950) # could replace 127.0.0.1 with your "real" IP if desired.
	word = ARGV[1]

	previous_sentence = read_file

	unless previous_sentence.nil?
		previous_sentence.push(word)
		word = previous_sentence.join(" ")
	end
	puts "Sending Message: " + word
	a.write word
	a.close
end


def read_file
	file = 'data.txt'
	lines = ''
	if File.exists?(file)
		File.readlines(file).each do |line|
		 	 lines.concat(line)
		end
	end
end

def check_arg
	abort("Not enough arguments") unless ARGV.size > 1
end


create_socket


