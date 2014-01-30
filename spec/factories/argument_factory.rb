FactoryGirl.define do
  factory :argument do
    content "das sehe ich ganz anders"
    association :question, factory: :question
    association :discussion, factory: :discussion
    argument_type ArgumentType.where(name:'proband').first
  end
end