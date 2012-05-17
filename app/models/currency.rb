class Currency < ActiveRecord::Base
  default_scope :order => 'code'

  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

  has_many :companies
  has_many :expense_details

  before_destroy :ensure_not_referenced_by_any_company
  before_destroy :ensure_not_referenced_by_any_expense_detail

  attr_accessible :code, :name

  private

    # ensure that there are no companies referencing this currency
    def ensure_not_referenced_by_any_company
      if companies.empty?
        return true
      else
        errors.add(:base, 'There are companies referencing this currency')
        return false
      end
    end

    # ensure that there are no expense_details referencing this currency
    def ensure_not_referenced_by_any_expense_detail
      if expense_details.empty?
        return true
      else
        errors.add(:base, 'There are expense_details referencing this currency')
        return false
      end
    end

end
