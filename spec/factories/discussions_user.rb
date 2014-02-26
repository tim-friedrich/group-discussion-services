#    t.integer  "user_id"
#    t.integer  "discussion_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"

FactoryGirl.define do
  factory :discussions_user do
  	association :user, factory: :user
  	association :discussion, factory: :discussion
  end
end