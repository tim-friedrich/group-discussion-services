require 'spec_helper'

RSpec.describe Company, :type => :model do
  let(:company) { F.build_stubbed(:company) }

  subject { company }

  it { should respond_to(:name) }
  it { should respond_to(:contact) }
  it { should respond_to(:research_institute) }
end
