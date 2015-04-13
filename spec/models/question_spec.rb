require 'spec_helper'

RSpec.describe Question, :type => :model do
  let(:question){ F.build_stubbed(:question) }

  subject { question }

  it { should respond_to(:topic) }
  it { should respond_to(:discussion) }

  it "should be invalid when topic is not present" do
    question.topic = nil
    should_not be_valid
  end

  it "should be invalid when discussion is not present" do
    question.discussion_id = nil
    should_not be_valid
  end
end
