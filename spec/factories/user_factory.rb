FactoryGirl.define do
  factory :user do
	sequence(:firstname)  { |n| "User #{n}" }
    sequence(:lastname)  { |n| "the #{n} of his kind" }
    sequence(:email) { |n| "user_#{n}@example.com" } 
    password "123456"
    password_confirmation "123456"
    role Role.where(name:"user").first
  end
end