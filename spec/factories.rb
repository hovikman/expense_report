include ActionDispatch::TestProcess

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
  
  factory :currency do
    sequence(:code, "A00") { |s| s }
    sequence(:name)       { |n| "Sample Currency #{n}" }
  end
  
  factory :expense do
    advance_pay       0.00
    expense_status_id { ExpenseStatus.new_id }
    purpose           'Sample Purpose'
    submit_date       { DateTime.now.to_date }
    user
    after(:build)     { |expense| expense.owner_id = expense.user_id }
    
    factory :expense_with_attachments do
      ignore do
        attachments_count 3
      end
      after(:create) do |expense, evaluator|
        FactoryGirl.create_list(:expense_attachment, evaluator.attachments_count, expense: expense)
      end
    end

    factory :expense_with_details do
      ignore do
        details_count 5
      end
      after(:create) do |expense, evaluator|
        FactoryGirl.create_list(:expense_detail, evaluator.details_count, expense: expense)
      end
    end

    factory :expense_with_details_and_attachments do
      ignore do
        details_count     5
        attachments_count 3
      end
      after(:create) do |expense, evaluator|
        FactoryGirl.create_list(:expense_detail, evaluator.details_count, expense: expense)
        FactoryGirl.create_list(:expense_attachment, evaluator.attachments_count, expense: expense)
      end
    end
  end
 
  factory :expense_attachment do
    description 'Sample Description'
    expense
    file_path   { fixture_file_upload(Rails.root.join('spec', 'support', 'test_files', 'burney_falls.jpg'), 'image/jpg') }
  end
  
  factory :expense_detail do
    sequence(:amount, 50)
    sequence(:comments) { |n| "Sample Comment #{n}" } 
    currency
    date                { DateTime.now.to_date }
    exchange_rate       1.00
    expense
    expense_type
  end
  
  factory :expense_status do
    sequence(:name) { |n| "Sample Expense Status #{n}" }
  end
  
  factory :expense_type do
    company
    sequence(:name) { |n| "Sample Expense Type #{n}" }
  end
  
  factory :user, aliases: [:regular_user] do
    company               
    email                 { "#{name}@#{company.name}.com".downcase }
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
  
  factory :user_type do
    sequence(:name) { |n| "Sample User Type #{n}" }
  end

end