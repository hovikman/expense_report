FactoryGirl.define do

  factory :expense_status do
    sequence(:name) { |n| "Sample Expense Status #{n}" }
  end
  
end