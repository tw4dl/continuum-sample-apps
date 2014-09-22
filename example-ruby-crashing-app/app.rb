require "sinatra"

class App < Sinatra::Base
  get "/" do
    "OK"
  end

  get "/crash" do
    puts "crashing!"
    Process.exit!(1)
  end
end
