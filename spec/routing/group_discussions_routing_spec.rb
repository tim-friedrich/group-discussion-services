require "spec_helper"

describe GroupDiscussionsController do
  describe "routing" do

    it "routes to #index" do
      get("/group_discussions").should route_to("group_discussions#index")
    end

    it "routes to #new" do
      get("/group_discussions/new").should route_to("group_discussions#new")
    end

    it "routes to #show" do
      get("/group_discussions/1").should route_to("group_discussions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/group_discussions/1/edit").should route_to("group_discussions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/group_discussions").should route_to("group_discussions#create")
    end

    it "routes to #update" do
      put("/group_discussions/1").should route_to("group_discussions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/group_discussions/1").should route_to("group_discussions#destroy", :id => "1")
    end

  end
end
