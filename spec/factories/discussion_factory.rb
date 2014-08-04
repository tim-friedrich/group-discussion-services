#    t.string   "topic"
#    t.integer  "moderator_id"
#    t.datetime "due_date"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "current_question_id"
#    t.integer  "company_id"

FactoryGirl.define do
  factory :discussion do
    topic "Test Topic"
    due_date DateTime.new(2020,2,3)
    association :moderator, factory: :user 
    association :company
  end
end