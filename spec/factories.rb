FactoryGirl.define do

  factory :company do
    accountant_id   nil
    contact_email   { "#{contact_person}@#{name}.com".downcase }
    contact_person  'SamplePerson'
    contact_phone   '5103531846'
    contact_title   'Sample Title'
    currency_id     { Currency.find_by_code('USD').id }
    sequence(:name) { |n| "SampleCompany#{n}" }    
  end
  
  factory :currency do
    sequence(:code, 'A') { |char| "AA#{char}" }
    sequence(:name)      { |n| "Sample Currency #{n}" }
  end
  
  factory :expense do
    advance_pay       0.00
    expense_status_id { ExpenseStatus.new_id }
    purpose           'Sample Purpose'
    submit_date       { DateTime.now.to_date }
    user_id           { current_user.id }    
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
    description          'Sample Description'
    expense
    sequence(:file_path) { |n| "c:/sample_dir/sample_file#{n}.txt" }
  end
  
  factory :expense_detail do
    sequence(:amount, 50)
    sequence(:comments) { |n| "Sample Comment #{n}" } 
    currency_id         { Currency.find_by_code('USD').id }
    date                { DateTime.now.to_date }
    exchange_rate       1.00
    expense
    expense_type_id     { ExpenseType.find_by_name('Meal').id }
  end
  
  factory :expense_status do
    sequence(:name) { |n| "Sample Expense Status #{n}" }
  end
  
  factory :expense_type do
    company_id      { Company.vendor_id }
    sequence(:name) { |n| "Sample Expense Type #{n}" }
  end
  
  factory :user, aliases: [:vendor_admin] do
    company               { Company.find(Company.vendor_id) }
    email                 { "#{name}@#{company.name}.com".downcase }
    sequence(:name)       { |n| "VendorAdmin#{n}" }
    password              'foobar'
    password_confirmation 'foobar'
    phone                 '5103531846'
    user_type_id          { UserType.vendor_admin_id }
    
    factory :regular_user do
      sequence(:name)  { |n| "RegularUser#{n}" }
      user_type_id     { UserType.regular_user_id }
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