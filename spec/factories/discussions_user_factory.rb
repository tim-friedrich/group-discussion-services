FactoryGirl.define do
  factory :discussions_user do
    association :discussion
    association :user, factory: :user_with_survey
    confirmed false
    factory :discussions_user_confirmed do
      confirmed true
    end
  end
end