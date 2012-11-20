class ExpenseType < ActiveRecord::Base
  # Attributes
  attr_accessible :company_id,
                  :name
                  
  # Scopes
  scope :for_datatable, select('expense_types.id, expense_types.name, companies.name as company_name') 
    .joins(:company)

  # Associations
  has_many :expense_details
  belongs_to :company

  # Validations
  validates :company_id, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :company_id

  # Callbacks
  before_destroy :ensure_not_referenced_by_any_expense_detail

  private

    # ensure that there are no expense_details referencing this expense_type
    def ensure_not_referenced_by_any_expense_detail
      raise "Cannot delete expense type '#{name}'. There are expense details referencing this expense type." unless expense_details.empty?
    end

end
