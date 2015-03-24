FactoryGirl.define do
  factory :argument do
    content "das sehe ich ganz anders"
    association :discussion
    argument_type { ArgumentType.where(name:'proband').first }
    association :user
    association :question
    factory :observer_argument do
      argument_type { ArgumentType.where(name:'observer').first }
    end
  end
end