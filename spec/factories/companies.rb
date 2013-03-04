FactoryGirl.define do

  factory :company do
    accountant_id   nil
    contact_email   { "#{contact_person}@#{name}.com".downcase }
    contact_person  'SamplePerson'
    contact_phone   '5103531846'
    contact_title   'Sample Title'
    currency
    sequence(:name) { |n| "SampleCompany#{n}" }    
  end
  
end