require "spec_helper"

describe DislikesController do
  describe "routing" do

    it "routes to #index" do
      get("/dislikes").should route_to("dislikes#index")
    end

    it "routes to #new" do
      get("/dislikes/new").should route_to("dislikes#new")
    end

    it "routes to #show" do
      get("/dislikes/1").should route_to("dislikes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dislikes/1/edit").should route_to("dislikes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dislikes").should route_to("dislikes#create")
    end

    it "routes to #update" do
      put("/dislikes/1").should route_to("dislikes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dislikes/1").should route_to("dislikes#destroy", :id => "1")
    end

  end
end
