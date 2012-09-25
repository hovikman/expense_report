class Company < ActiveRecord::Base
  # Attributes
  attr_accessible :accountant_id,
                  :contact_email,
                  :contact_person,
                  :contact_phone,
                  :contact_title,
                  :currency_id,
                  :name
  # Scope
  default_scope order: 'name'
                   
  # Associations
  has_many :users
  has_many :expense_types
  belongs_to :currency
  belongs_to :accountant, class_name: "User", foreign_key: "accountant_id"
  
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :currency_id, presence: true
  validates :contact_person, presence: true
  validates :contact_title, presence: true
  validates :contact_phone, presence: true
  validates :contact_email, presence: true

  # Callbacks
  before_destroy :ensure_cannot_delete_vendor
  before_update  :ensure_vendor_name_not_changed
  before_destroy :ensure_not_referenced_by_any_user
  before_destroy :ensure_not_referenced_by_any_expense_type

  # Constants
  VENDOR_NAME_STR = "Vendor"

  # Methods
  def self.vendor_id
    find_by_name(VENDOR_NAME_STR).id
  end
 
  private


    def ensure_cannot_delete_vendor
      raise "Cannot delete the vendor company." if name == VENDOR_NAME_STR
    end

    def ensure_vendor_name_not_changed
      if (name_was == VENDOR_NAME_STR) && name_changed?
        errors.add(:name, "'Vendor' cannot be changed")
        return false
      end 
    end
    
    def ensure_not_referenced_by_any_user
      raise "Cannot delete company '#{name}'. There are users referencing this company." unless users.empty?
    end

    def ensure_not_referenced_by_any_expense_type
      raise "Cannot delete company '#{name}'. There are expense types referencing this company." unless expense_types.empty?
    end
    
end
