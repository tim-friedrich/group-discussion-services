require "spec_helper"


RSpec.describe QuestionsController, :type => :routing do
  describe "routing" do
    it "routes to #create" do
      post("/questions").should route_to("questions#create")
    end
  end
end
