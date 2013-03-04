FactoryGirl.define do

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

end