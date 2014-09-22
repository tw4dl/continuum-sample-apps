require "sinatra"
require "bunny"

conn = Bunny.new(ENV["AMQP_URI"])
conn.start

channel = conn.create_channel
queue = channel.queue("test-queue")

post "/publish" do
  queue.publish(params[:message] || "test")
end

get "/pop" do
  _, _, payload = queue.pop
  payload
end
