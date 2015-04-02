FactoryGirl.define do
  factory :visual_aid do
    discussion
    name "something"
    file { File.new("#{Rails.root}/spec/fixtures/pixel.png") }
  end
end
