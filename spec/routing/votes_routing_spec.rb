require "spec_helper"


RSpec.describe VotesController, :type => :routing do
  describe "routing" do
    it "routes to #create" do
      post("/votes").should route_to("votes#create")
    end
  end
end
