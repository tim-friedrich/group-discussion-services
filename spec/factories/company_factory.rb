#    t.string   "name"
#    t.integer  "contact_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "research_institute_id"

FactoryGirl.define do 
	factory :company do
		name "test"
		:contact
		:research_institute
	end
end