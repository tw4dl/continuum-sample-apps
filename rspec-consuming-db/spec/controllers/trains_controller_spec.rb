require 'spec_helper'

describe TrainsController do
  describe "GET index" do
    it "assigns @trains" do
      get :index # makes a request to bart.gov
      expect(assigns(:trains)).to_not be_blank
      expect(response).to render_template("index")
    end
  end
end
