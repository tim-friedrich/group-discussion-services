FactoryGirl.define do
  factory :user_relation do
    user_id
    institute_id
    institute_type "ResearchInstitute"
    role
  end
end
