require "spec_helper"

describe GreenhousesController do
  describe "routing" do

    it "routes to #index" do
      get("/greenhouses").should route_to("greenhouses#index")
    end

    it "routes to #new" do
      get("/greenhouses/new").should route_to("greenhouses#new")
    end

    it "routes to #show" do
      get("/greenhouses/1").should route_to("greenhouses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/greenhouses/1/edit").should route_to("greenhouses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/greenhouses").should route_to("greenhouses#create")
    end

    it "routes to #update" do
      put("/greenhouses/1").should route_to("greenhouses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/greenhouses/1").should route_to("greenhouses#destroy", :id => "1")
    end

  end
end
