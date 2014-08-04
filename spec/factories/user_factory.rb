#    t.string   "firstname"
#    t.string   "lastname"
#    t.string   "email"
#    t.string   "password_digest"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "remember_token"
#    t.integer  "role_id"

FactoryGirl.define do
  factory :user do
	  sequence(:firstname)  { |n| "User #{n}" }
    sequence(:username)  { |n| "User #{n}" }
    sequence(:lastname)  { |n| "the #{n} of his kind" }
    sequence(:email) { |n| "user_#{n}@example.com" } 
    password "123456789"
    password_confirmation "123456789"
    role Role.where(name:"user").first
  end
end