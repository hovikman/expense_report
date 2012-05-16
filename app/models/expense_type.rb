class ExpenseType < ActiveRecord::Base
  default_scope :order => 'name'

  validates :company_id, :presence => true
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :company_id

  belongs_to :company

  attr_accessible :company_id, :name
end
