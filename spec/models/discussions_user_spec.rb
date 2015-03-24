require 'spec_helper'

describe DiscussionsUser do
  let(:discussions_user){ create(:discussions_user) }

  it "should have a name" do
    expect( discussions_user.name ).not_to be_blank
  end

  it "should select a name from the list" do
    names = ["peter", "hans", "karl", "kalle"]
    expect( discussions_user.select_name_from(names) ).to be_in names
  end
end
