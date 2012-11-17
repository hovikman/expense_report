class Expense < ActiveRecord::Base
  # Attributes
  attr_accessible :advance_pay,
                  :expense_status_id,
                  :owner_id,
                  :purpose,
                  :submit_date,
                  :user_id
  # Scopes
  scope :for_datatable, select('expenses.id, users.name as user_name, expenses.submit_date, expenses.purpose, expense_statuses.name as status_name, ' +
                               'COALESCE(sum(expense_details.exchange_rate * expense_details.amount), 0.00) as amount')
    .joins(:user)
    .joins(:expense_status)
    .joins('LEFT JOIN expense_details ON expenses.id = expense_details.expense_id')
    .group('expenses.id, users.name, expense_statuses.name')
                  
  # Associations
  has_many :expense_details, dependent: :delete_all
  has_many :expense_attachments, dependent: :delete_all
  belongs_to :user
  belongs_to :expense_status
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  # Validations
  validates :advance_pay, presence: true, numericality: {greater_than_or_equal_to: 0.00}
  validates :expense_status_id, presence: true
  validates :purpose, presence: true
  validates :submit_date, presence: true
  validates :user_id, presence: true

  # Default values
  attr_defaults advance_pay: 0.00
  attr_defaults submit_date: lambda {DateTime.now.to_date}
end