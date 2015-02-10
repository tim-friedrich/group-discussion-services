require 'spec_helper'
#    t.string   "name"
#    t.integer  "contact_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "research_institute_id"

describe Company do
  let(:company) { FactoryGirl.build(:company) }

  subject { company }

  it { should respond_to(:name) }
  it { should respond_to(:contact) }
  it { should respond_to(:research_institute) }
  it { should be_valid }
end
