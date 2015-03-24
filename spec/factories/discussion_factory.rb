FactoryGirl.define do
  factory :discussion do
    topic "Test Topic"
    due_date DateTime.new(2020,2,3)
    association :moderator
    association :company
    state 'open'

    after :create do |discussion, evaluator|
      create_list(:question, 1, discussion: discussion)
      create_list(:discussions_user_confirmed, 8, discussion: discussion)
    end
  end
end