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
    association :question, factory: :question
    association :discussion, factory: :discussion
    argument_type ArgumentType.where(name:'proband').first
    

    before(:create) do | user |
    	user = FactoryGirl.create(:user)
    end
  end
end