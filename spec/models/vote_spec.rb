require 'spec_helper'

RSpec.describe Vote, :type => :model do
  let(:vote){ F.build_stubbed(:vote) }

  subject { vote }
  it { should respond_to(:argument) }
  it { should respond_to(:user) }
  it { should respond_to(:is_like) }

  describe "when argument is not present" do
    before { vote.argument = nil }
    it { should_not be_valid }
  end
end