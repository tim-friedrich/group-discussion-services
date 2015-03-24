require 'spec_helper'

describe Company do
  let(:company) { FactoryGirl.build(:company) }

  subject { company }

  it { should respond_to(:name) }
  it { should respond_to(:contact) }
  it { should respond_to(:research_institute) }
  it { should be_valid }
end
