require 'spec_helper'
#    t.string   "name"
#    t.integer  "contact_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "deputy_id"

describe ResearchInstitute do
  let(:research_institute) { FactoryGirl.create(:research_institute) }

  it { research_institute.should respond_to(:name) }
  it { research_institute.should respond_to(:contact) }
  it { research_institute.should respond_to(:deputy) }
end
