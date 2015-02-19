require 'spec_helper'

describe DiscussionsUser do
  let(:discussions_user){ create(:discussions_user) }

  it "should have a name" do
    expect( discussions_user.name ).not_to be_blank
  end
end
