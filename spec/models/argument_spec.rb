require 'spec_helper'

RSpec.describe Argument, :type => :model do
  let(:argument){ F.build_stubbed(:argument) }

  subject{ argument }

  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:question) }
  it { should respond_to(:argument_type) }


  describe "when content not present" do
    before { argument.content = " " }
    it { should_not be_valid }
  end

  describe "when user is not present" do
    before { argument.user = nil }
    it { should_not be_valid }
  end

  describe "when question is not present" do
    before { argument.question = nil }
    it { should_not be_valid }
  end

  describe "when argument type is not present" do
    before { argument.argument_type = nil }
    it { should_not be_valid }
  end
end
