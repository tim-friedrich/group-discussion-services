require 'spec_helper'

RSpec.describe Discussion, :type => :model do
  let(:discussion){ F.create(:discussion) }

  subject { discussion }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:topic) }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:moderator) }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:due_date) }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:current_question) }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:company) }
  it { expect( F.build_stubbed(:discussion) ).to respond_to(:questions) }

  describe "when due_date is not present" do
    before { discussion.due_date = nil }
    it { should_not be_valid }
  end

  it "should return the new current question if a new question is created" do
    question = F.create(:question, discussion: discussion)
    expect( discussion.current_question ).to eq question
  end
end
