require 'spec_helper'

RSpec.describe ResearchInstitute, :type => :model do
  let(:research_institute) { F.build_stubbed(:research_institute) }

  it { research_institute.should respond_to(:name) }
  it { research_institute.should respond_to(:contact) }
  it { research_institute.should respond_to(:deputy) }
end
