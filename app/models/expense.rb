class Expense < ActiveRecord::Base
  # Attributes
  attr_accessible :advance_pay,
                  :expense_status_id,
                  :owner_id,
                  :purpose,
                  :submit_date,
                  :user_id
                  
  # Scope
  default_scope order: 'submit_date'

  # Associations
  has_many :expense_details, dependent: :delete_all
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
  attr_defaults expense_status_id: lambda {ExpenseStatus.new_id}
  attr_defaults submit_date: lambda {DateTime.now.to_date}

  # Callbacks
  before_create { self.owner_id = self.user_id }
  before_create { self.expense_status_id = ExpenseStatus.new_id }
  
  # Methods
  def total_amount
    expense_details.inject(0) {|sum, expense_detail| sum + expense_detail.total_amount()} - advance_pay
  end
end
