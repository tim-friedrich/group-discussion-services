FactoryGirl.define do
  factory :question do
    topic "Test Topic"
    association :discussion
  end
end