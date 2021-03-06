class Currency < ActiveRecord::Base
  # Attributes
  attr_accessible :code,
                  :name
                  
  # Associations
  has_many :companies
  has_many :expense_details

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 30 }
  validates :code, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 3 }

  # Callbacks
  before_save { self.code.upcase! }
  before_destroy :ensure_not_referenced_by_any_company
  before_destroy :ensure_not_referenced_by_any_expense_detail

  # Methods
  def code_and_name
    code + ' ' + name
  end
  
  private
    # ensure that there are no companies referencing this currency
    def ensure_not_referenced_by_any_company
      raise "Cannot delete currency '#{name}'. There are companies referencing this currency." unless companies.empty?
    end
  
    # ensure that there are no expense_details referencing this currency
    def ensure_not_referenced_by_any_expense_detail
      raise "Cannot delete currency '#{name}'. There are expens details referencing this currency." unless expense_details.empty?
    end
end