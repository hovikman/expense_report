class ExpenseStatus < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true

  attr_accessible :name

  # constants for predefined expense status values
  NOT_APPROVED_STR = "Not Approved"
  APPROVED_STR     = "Approved"
  DECLINED_STR     = "Declined"

  def self.not_approved_id
    find_by_name(NOT_APPROVED_STR).id
  end

  def self.approved_id
    find_by_name(APPROVED_STR).id
  end

  def self.declined_id
    find_by_name(DECLINED_STR).id
  end

end
