require "securerandom"
require "socket"

# get the port and validate it
port = ENV["PORT"].to_i
raise "PORT was not set or was set to 0, please set a real port!" if port == 0

# get our random text, or just generate some ourself
random_text = ENV["RANDOM_TEXT"] || SecureRandom.hex(50)

# create the server on the port set via the environment
server = TCPServer.new(port)

# loop
loop do
  begin
    # wait for a connection
    client = server.accept

    # write our text then close
    client.puts random_text
    client.close
  rescue
  end
end
