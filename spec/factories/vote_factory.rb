FactoryGirl.define do
  factory :vote do
    is_like true
    association :user
    association :argument
  end
end