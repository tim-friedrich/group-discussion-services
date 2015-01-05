require "spec_helper"

describe QuestionsController do
  describe "routing" do
    it "routes to #create" do
      post("/questions").should route_to("questions#create")
    end
  end
end
