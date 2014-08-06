require 'spec_helper'
#    t.string   "street"
#    t.string   "postalcode"
#    t.string   "town"
#    t.string   "email"
#    t.string   "telephone"
#    t.datetime "created_at"
#    t.datetime "updated_at"

describe Contact do
	let(:contact) { FactoryGirl.create(:contact) }

  subject { contact }
	it { should respond_to(:street) }
	it { should respond_to(:postalcode) }
	it { should respond_to(:town) }
	it { should respond_to(:telephone) }
  it { should be_valid }
end 
