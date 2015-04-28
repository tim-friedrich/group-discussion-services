FactoryGirl.define do
  factory :company do
    name "test"
    association :contact
  end
end