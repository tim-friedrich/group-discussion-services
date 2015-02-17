require "spec_helper"


RSpec.describe ResearchInstitutesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      get("/research_institutes").should route_to("research_institutes#index")
    end

    it "routes to #new" do
      get("/research_institutes/new").should route_to("research_institutes#new")
    end

    it "routes to #show" do
      get("/research_institutes/1").should route_to("research_institutes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/research_institutes/1/edit").should route_to("research_institutes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/research_institutes").should route_to("research_institutes#create")
    end

    it "routes to #update" do
      put("/research_institutes/1").should route_to("research_institutes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/research_institutes/1").should route_to("research_institutes#destroy", :id => "1")
    end

  end
end
