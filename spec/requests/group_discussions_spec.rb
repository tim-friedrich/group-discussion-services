require 'spec_helper'

describe "GroupDiscussions" do
  describe "GET /group_discussions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get group_discussions_path
      response.status.should be(200)
    end
  end
end
