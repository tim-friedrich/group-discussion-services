require 'spec_helper'

describe ResearchInstitute do
  let(:research_institute) { FactoryGirl.create(:research_institute) }

  it { research_institute.should respond_to(:name) }
  it { research_institute.should respond_to(:contact) }
  it { research_institute.should respond_to(:deputy) }
end
