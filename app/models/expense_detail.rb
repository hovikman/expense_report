class ExpenseDetail < ActiveRecord::Base
  default_scope :order => 'expense_id'
  default_scope :order => 'date'

  validates :amount, :presence => true
  validates :currency_id, :presence => true
  validates :date, :presence => true
  validates :exchange_rate, :presence => true
  validates :expense_id, :presence => true
  validates :expense_type_id, :presence => true

  attr_defaults :amount => 0.0
  # attr_defaults :currency_id => lambda { Company.find(User.find(Expense.find(expense_id).user_id).company_id).currency_id }
  attr_defaults :date => lambda { Time.now }
  attr_defaults :exchange_rate => 1.00
  # attr_defaults :expense_id => ?

  belongs_to :currency
  belongs_to :expense
  belongs_to :expense_type

  attr_accessible :amount,
                  :comments,
                  :currency_id,
                  :date,
                  :exchange_rate,
                  :expense_id,
                  :expense_type_id
end
