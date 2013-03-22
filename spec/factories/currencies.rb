FactoryGirl.define do

  factory :currency do
    sequence(:code, "A00") { |s| s }
    sequence(:name)        { |n| "Sample Currency #{n}" }
  end

end