#    t.string   "name"
#    t.integer  "contact_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "deputy_id"

FactoryGirl.define do
	factory :research_institute do
		name "Example institute"
		:contact
		association :deputy, factory: :user
	end
end