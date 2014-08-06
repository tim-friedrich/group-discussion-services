#    t.integer  "argument_id"
#    t.integer  "user_id"
#    t.boolean  "is_like"
#    t.datetime "created_at"
#    t.datetime "updated_at"

FactoryGirl.define do
  factory :vote do
    is_like true
    association :user
    association :argument
  end
end