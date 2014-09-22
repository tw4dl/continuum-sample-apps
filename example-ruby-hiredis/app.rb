require "redis"
require "sinatra"
require "uri"

class App < Sinatra::Base
  helpers do
    def redis
      uri = URI(ENV["REDIS_URI"])
      Redis.new(:host => uri.host, :port => uri.port, :db => uri.path.sub("/",""))
    end
  end

  get "/" do
    "Hello, World!"
  end

  get "/get/:key" do |key|
    puts "Retrieving value for #{key}"
  	redis.get(key)
  end

  post "/set/:key/:value" do |key,value|
    puts "Setting value #{key} = #{value}"
    redis.set(key, value)
  	"OK"
  end
end
