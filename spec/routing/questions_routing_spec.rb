require "spec_helper"

describe QuestionsController do
  describe "routing" do

    it "routes to #new" do
      get("/questions/new").should route_to("questions#new")
    end

    it "routes to #show" do
      get("/questions/1").should route_to("questions#show", :id => "1")
    end

    it "routes to #create" do
      post("/questions").should route_to("questions#create")
    end
  end
end
