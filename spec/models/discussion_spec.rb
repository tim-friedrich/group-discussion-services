require 'spec_helper'

describe Discussion do
  let(:discussion){ FactoryGirl.build(:discussion) }

  subject { discussion }
  it { should respond_to(:topic) }
  it { should respond_to(:moderator) }
  it { should respond_to(:due_date) }
  it { should respond_to(:current_question) }
  it { should respond_to(:company) }
  it { should respond_to(:questions) }
  it { should be_valid }

  describe "when due_date is not present" do
    before { discussion.due_date = nil }
    it { should_not be_valid }
  end

  it "should return the new current question if a new question is created" do
    question = FactoryGirl.create(:question, discussion: discussion)
    expect( discussion.current_question ).to eq question
  end

  it "should return the research institute that the discussion belongs to" do
    research_institute = FactoryGirl.create(:research_institute)
    moderator = create(:moderator)
    discussion.save
    moderator.research_institutes << research_institute
    discussion.moderator = moderator
    expect( discussion.research_institute ).to eq research_institute
  end

end
