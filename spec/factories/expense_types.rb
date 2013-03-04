FactoryGirl.define do

  factory :expense_type do
    company
    sequence(:name) { |n| "Sample Expense Type #{n}" }
  end
  
end