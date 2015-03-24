require 'spec_helper'

describe Contact do
  let(:contact) { FactoryGirl.create(:contact) }

  subject { contact }
  it { should respond_to(:street) }
  it { should respond_to(:postalcode) }
  it { should respond_to(:town) }
  it { should respond_to(:telephone) }
  it { should be_valid }
end
