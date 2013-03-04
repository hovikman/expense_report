FactoryGirl.define do

  factory :user_type do
    sequence(:name) { |n| "Sample User Type #{n}" }
  end

end