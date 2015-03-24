require 'spec_helper'

describe Vote do
  before do
    @vote = FactoryGirl.build(:vote)
  end

  subject { @vote }
  it { should respond_to(:argument) }
  it { should respond_to(:user) }
  it { should respond_to(:is_like) }

  it { should be_valid }

  describe "when argument is not present" do
    before { @vote.argument = nil }
    it { should_not be_valid }
  end
end