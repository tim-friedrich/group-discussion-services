require "spec_helper"

describe DiscussionsController do
  describe "routing" do

    it "routes to #index" do
      get("/discussions").should route_to("discussions#index")
    end

    it "routes to #new" do
      get("/discussions/new").should route_to("discussions#new")
    end

    it "routes to #show" do
      get("/discussions/1").should route_to("discussions#show", id: "1")
    end

    it "routes to #edit" do
      get("/discussions/1/edit").should route_to("discussions#edit", id: "1")
    end

    it "routes to #create" do
      post("/discussions").should route_to("discussions#create")
    end

    it "routes to #update" do
      put("/discussions/1").should route_to("discussions#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/discussions/1").should route_to("discussions#destroy", id: "1")
    end

    it "routes to #leave" do
      post("/discussions/1/leave").should route_to("discussions#leave", id: "1")
    end

    it "routes to #user_leaved" do
      get("/user_leaved/1").should route_to("discussions#user_leaved", id: "1")
    end

    it "routes to #user_entered" do
      get("/user_entered/1").should route_to("discussions#user_entered", id: "1")
    end

    it "routes to #evaluate" do
      get("/discussions/1/evaluate").should route_to("discussions#evaluate", id: "1")
    end
  end
end
