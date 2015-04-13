require 'spec_helper'

RSpec.describe Contact, :type => :model do
  let(:contact) { F.build_stubbed(:contact) }

  subject { contact }
  it { should respond_to(:street) }
  it { should respond_to(:postalcode) }
  it { should respond_to(:town) }
  it { should respond_to(:telephone) }
end
