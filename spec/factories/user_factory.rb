FactoryGirl.define do
  factory :user do
    sequence(:firstname)  { |n| "User #{n}" }
    sequence(:lastname)  { |n| "the #{n} of his kind" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password "123456789"
    password_confirmation "123456789"
    gender "female"
    birthday Date.today - 23.years
    zipcode "10117"
    country "Internet"
    city "Postamt"
    pseudonym_policy true
    confirmed_at Date.yesterday

    role { Role.proband }

    factory :user_with_survey do
      survey
    end

    factory :moderator do
      role { Role.moderator }
    end

    factory :customer do
      role { Role.customer }      
    end

    factory :user_without_gender do
      gender "other"
    end
  end
end