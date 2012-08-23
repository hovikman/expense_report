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

  has_many :expense_details, :dependent => :delete_all

  belongs_to :user
  belongs_to :expense_status
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  
  before_create { self.owner_id = self.user_id }
  before_create { self.expense_status_id = ExpenseStatus.new_id }
  
  attr_accessible :advance_pay, :expense_status_id, :purpose, :submit_date, :user_id
  
end
