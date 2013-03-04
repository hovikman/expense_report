FactoryGirl.define do

  factory :expense_detail do
    sequence(:amount, 50)
    sequence(:comments) { |n| "Sample Comment #{n}" } 
    currency
    date                { DateTime.now.to_date }
    exchange_rate       1.00
    expense
    expense_type
  end

end