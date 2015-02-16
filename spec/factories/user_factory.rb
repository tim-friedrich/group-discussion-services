#    t.string   "firstname"
#    t.string   "lastname"
#    t.string   "email"
#    t.string   "password_digest"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "remember_token"
#    t.integer  "role_id"

# TODO different roles

FactoryGirl.define do
  factory :user do
    sequence(:firstname)  { |n| "User #{n}" }
    sequence(:username)  { |n| "User #{n}" }
    sequence(:lastname)  { |n| "the #{n} of his kind" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password "123456789"
    password_confirmation "123456789"
    confirmed_at Date.yesterday
    role { Role.where(name:"proband").first }

    factory :user_with_survey do
      survey
    end

    factory :moderator do
      role { Role.where(name:'moderator').first }
    end
  end
end