class Expense < ActiveRecord::Base
  default_scope :order => 'submit_date'

  validates :advance_pay, :presence => true
  validates :expense_status_id, :presence => true
  validates :purpose, :presence => true
  validates :submit_date, :presence => true
  validates :user_id, :presence => true

  attr_defaults :advance_pay => 0.0
  attr_defaults :expense_status_id => lambda { ExpenseStatus.not_approved_id }
  attr_defaults :submit_date => lambda { Time.now }

  belongs_to :user
  belongs_to :expense_status

  attr_accessible :advance_pay, :expense_status_id, :purpose, :submit_date, :user_id
end
