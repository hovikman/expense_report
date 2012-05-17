class Currency < ActiveRecord::Base
  default_scope :order => 'code'

  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

  has_many :companies

  before_destroy :ensure_not_referenced_by_any_company

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

end
