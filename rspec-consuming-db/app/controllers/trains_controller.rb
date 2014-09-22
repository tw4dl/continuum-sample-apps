class TrainsController < ApplicationController
  def index
    @trains = HTTParty.get "http://api.bart.gov/api/etd.aspx",
      :query => { :cmd => "etd", :orig => "mont", :key => "MW9S-E7SL-26DU-VV8V"}
  end
end
