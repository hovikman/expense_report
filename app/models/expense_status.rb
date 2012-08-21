class ExpenseStatus < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true

  has_many :expenses

  before_destroy :ensure_not_referenced_by_any_expense

  attr_accessible :name

  # constants for predefined expense status values
  NEW_STR = "New"
  ASSIGNED_TO_MANAGER_STR = "Assigned to manager"
  ASSIGNED_TO_ACCOUNTING_STR = "Assigned to accounting"
  APPROVED_STR     = "Approved"

  def self.new_id
    find_by_name(NEW_STR).id
  end
  
  def self.assigned_to_manager_id
    find_by_name(ASSIGNED_TO_MANAGER_STR).id
  end
  
  def self.assigned_to_accounting_id
    find_by_name(ASSIGNED_TO_ACCOUNTING_STR).id
  end

  def self.approved_id
    find_by_name(APPROVED_STR).id
  end

  private
    # ensure that there are no expenses referencing this user
    def ensure_not_referenced_by_any_expense
      raise "Cannot delete expense status '#{name}'. There are expenses referencing this expense status." unless expenses.empty?
    end

end
