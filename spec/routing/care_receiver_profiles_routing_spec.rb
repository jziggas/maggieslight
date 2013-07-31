require "spec_helper"

describe CareReceiverProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/care_receiver_profiles").should route_to("care_receiver_profiles#index")
    end

    it "routes to #new" do
      get("/care_receiver_profiles/new").should route_to("care_receiver_profiles#new")
    end

    it "routes to #show" do
      get("/care_receiver_profiles/1").should route_to("care_receiver_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/care_receiver_profiles/1/edit").should route_to("care_receiver_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/care_receiver_profiles").should route_to("care_receiver_profiles#create")
    end

    it "routes to #update" do
      put("/care_receiver_profiles/1").should route_to("care_receiver_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/care_receiver_profiles/1").should route_to("care_receiver_profiles#destroy", :id => "1")
    end

  end
end
