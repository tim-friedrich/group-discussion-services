require 'spec_helper'
#    t.string   "name"
#    t.integer  "contact_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "research_institute_id"

describe Company do
	let(:company) { FactoryGirl.create(:company) }
	
	it { company.should respond_to(:name) }
	it { company.should respond_to(:contact) }
	it { company.should respond_to(:research_institute) }
end
