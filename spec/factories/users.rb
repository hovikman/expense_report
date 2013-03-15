FactoryGirl.define do

  factory :user, aliases: [:regular_user] do
    company               
    email                 { "#{name}@samplecompany.com".downcase }
    manager_id            nil
    sequence(:name)       { |n| "RegularUser#{n}" }
    password              'foobar'
    password_confirmation 'foobar'
    phone                 '5103531846'
    user_type_id          { UserType.regular_user_id }
    
    factory :vendor_admin do
      company          { Company.find(Company.vendor_id) }
      sequence(:name)  { |n| "VendorAdmin#{n}" }
      user_type_id     { UserType.vendor_admin_id }
    end

    factory :company_admin do
      sequence(:name)  { |n| "CompanyAdmin#{n}" }
      user_type_id     { UserType.admin_id }
    end
  end
  
end