FactoryGirl.define do
  factory :user do
    company_id 1
    name     "Test User"
    phone    "1112223344"
    email    "test.user@testcompany.com"
    user_type_id 1
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :currency do
    sequence(:name) {|n| "Sample Currency #{n}" }
    sequence(:code, 'A') {|char| "AA#{char}"}
  end
end