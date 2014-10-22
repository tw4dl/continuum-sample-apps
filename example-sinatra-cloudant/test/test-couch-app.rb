ENV['RACK_ENV'] = 'test'

require_relative "../couch-app"
require "test/unit"
require "rack/test"

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  def test_responds
    get '/'
    assert last_response.ok?
  end

  def test_api_todos
    get '/api/todos'
    assert last_response.ok?
  end

  def test_api_insert
    post '/api/todos', "{}"
    assert last_response.ok?
  end
end
