class Expense < ActiveRecord::Base
  default_scope :order => 'submit_date'

  validates :advance_pay, :presence => true, :numericality => { :greater_than_or_equal_to => 0.00 }
  validates :expense_status_id, :presence => true
  validates :purpose, :presence => true
  validates :submit_date, :presence => true
  validates :user_id, :presence => true

  attr_defaults :advance_pay => 0.00
  attr_defaults :expense_status_id => lambda { ExpenseStatus.new_id }
  attr_defaults :submit_date => lambda { DateTime.now.to_date }

  has_many :expense_details

  belongs_to :user
  belongs_to :expense_status

  before_destroy :ensure_not_referenced_by_any_expense_detail

  attr_accessible :advance_pay, :expense_status_id, :purpose, :submit_date, :user_id

  private

    # ensure that there are no expense_details referencing this expense
    def ensure_not_referenced_by_any_expense_detail
      if expense_details.empty?
        return true
      else
        errors.add(:base, 'There are expense_details referencing this expense')
        return false
      end
    end

end
