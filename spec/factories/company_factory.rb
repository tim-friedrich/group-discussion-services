FactoryGirl.define do
  factory :company do
    name "test"
    association :contact
    association :research_institute
  end
end