require "spec_helper"

describe CareProviderProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/care_provider_profiles").should route_to("care_provider_profiles#index")
    end

    it "routes to #new" do
      get("/care_provider_profiles/new").should route_to("care_provider_profiles#new")
    end

    it "routes to #show" do
      get("/care_provider_profiles/1").should route_to("care_provider_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/care_provider_profiles/1/edit").should route_to("care_provider_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/care_provider_profiles").should route_to("care_provider_profiles#create")
    end

    it "routes to #update" do
      put("/care_provider_profiles/1").should route_to("care_provider_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/care_provider_profiles/1").should route_to("care_provider_profiles#destroy", :id => "1")
    end

  end
end
