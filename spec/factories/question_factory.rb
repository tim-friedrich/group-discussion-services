#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "topic"
#    t.integer  "discussion_id"

FactoryGirl.define do
  factory :question do
    topic "Test Topic"
  	:discussion
  end
end