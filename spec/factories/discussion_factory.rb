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
    association :moderator
    association :company

    after :create do |discussion, evaluator|
      create_list(:question, 1, discussion: discussion)
      create_list(:discussions_user_confirmed, 8, discussion: discussion)
    end
  end
end