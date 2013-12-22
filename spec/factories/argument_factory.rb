

FactoryGirl.define do
  factory :argument do
    content "das sehe ich ganz anders"

    association :user, factory: :user
    association :question, factory: :question
    argument_type ArgumentType.where(name:'proband').first
  end
end