class Company < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true
  validates :currency_id, :presence => true
  validates :contact_person, :presence => true
  validates :contact_title, :presence => true
  validates :contact_phone, :presence => true
  validates :contact_email, :presence => true

  has_many :users
  has_many :expense_types
  belongs_to :currency
  belongs_to :accountant, :class_name => "User", :foreign_key => "accountant_id"

  before_destroy :ensure_not_referenced_by_any_user
  before_destroy :ensure_not_referenced_by_any_expense_type

  attr_accessible :contact_email, :contact_person, :contact_phone, :contact_title, :currency_id, :name, :accountant_id

  # constant for name of the vendor
  VENDOR_NAME_STR = "Vendor"

  def self.vendor_id
    find_by_name(VENDOR_NAME_STR).id
  end
 
  private

    # ensure that there are no users referencing this company
    def ensure_not_referenced_by_any_user
      raise "Cannot delete company '#{name}'. There are users referencing this company." unless users.empty?
    end

    # ensure that there are no expense types referencing this company
    def ensure_not_referenced_by_any_expense_type
      raise "Cannot delete company '#{name}'. There are expense types referencing this company." unless expense_types.empty?
    end

end
