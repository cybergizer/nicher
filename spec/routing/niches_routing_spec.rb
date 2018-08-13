require "rails_helper"

RSpec.describe NichesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/niches").to route_to("niches#index")
    end

    it "routes to #new" do
      expect(:get => "/niches/new").to route_to("niches#new")
    end

    it "routes to #show" do
      expect(:get => "/niches/1").to route_to("niches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/niches/1/edit").to route_to("niches#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/niches").to route_to("niches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/niches/1").to route_to("niches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/niches/1").to route_to("niches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/niches/1").to route_to("niches#destroy", :id => "1")
    end
  end
end
