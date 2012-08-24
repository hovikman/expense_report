class ExpenseDetail < ActiveRecord::Base
  default_scope :order => 'expense_id'
  default_scope :order => 'date'

  validates :amount, :presence => true, :numericality => { :greater_than => 0.00 }
  validates :currency_id, :presence => true
  validates :date, :presence => true
  validates :exchange_rate, :presence => true, :numericality => { :greater_than => 0.00 }
  validates :expense_id, :presence => true
  validates :expense_type_id, :presence => true

  attr_defaults :amount => 0.0
  attr_defaults :date => lambda { DateTime.now.to_date }
  attr_defaults :exchange_rate => 1.00

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
                  
  def total_amount
    exchange_rate * amount
  end
  
end
