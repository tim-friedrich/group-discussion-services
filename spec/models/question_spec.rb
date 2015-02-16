require 'spec_helper'

describe Question do
  let(:question){ FactoryGirl.build(:question) }

  subject { question }

  it { should respond_to(:topic) }
  it { should respond_to(:discussion) }
  it { should be_valid }

  it "should be invalid when topic is not present" do
    question.topic = nil
    should_not be_valid
  end

  it "should be invalid when discussion is not present" do
    question.discussion_id = nil
    should_not be_valid
  end
end
