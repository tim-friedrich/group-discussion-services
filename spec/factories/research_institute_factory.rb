FactoryGirl.define do
  factory :research_institute do
    name "Example institute"
    association :contact, factory: :contact
    association :deputy, factory: :user
  end
end