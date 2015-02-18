#    t.text     "content"
#    t.integer  "user_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "question_id"
#    t.integer  "argument_type_id"
#    t.integer  "discussion_id"

FactoryGirl.define do
  factory :argument do
    content "das sehe ich ganz anders"
    association :discussion
    argument_type { ArgumentType.where(name:'proband').first }
    association :user
    association :question
    factory :observer_argument do
      argument_type { ArgumentType.where(name:'observer').first }
    end
  end
end