FactoryGirl.define do
  factory :discussion do
    topic "Test Topic"
    due_date DateTime.new(2001,2,3)
    association :moderator, factory: :user
  end
end