class TrainsController < ApplicationController
  def index
    @trains = HTTParty.get "http://api.bart.gov/api/etd.aspx",
      :query => { :cmd => "etd", :orig => "mont", :key => ENV['BART_KEY']}
  end
end
