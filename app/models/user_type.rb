class UserType < ActiveRecord::Base
  # Attributes
  attr_accessible :name
  
  # Scope
  default_scope order: 'name'

  # Associations
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true

  # Callbacks
  before_destroy :ensure_not_referenced_by_any_user

  # Constants
  ADMIN_STR        = "Administrator"
  REGULAR_USER_STR = "Regular User"
  VENDOR_ADMIN_STR = "Vendor Administrator"

  # Methods
  def self.admin_id
    find_by_name(ADMIN_STR).id
  end

  def self.regular_user_id
    find_by_name(REGULAR_USER_STR).id
  end

  def self.vendor_admin_id
    find_by_name(VENDOR_ADMIN_STR).id
  end

  private

    # ensure that there are no users referencing this user_type
    def ensure_not_referenced_by_any_user
      raise "Cannot delete user type '#{name}'. There are users referencing this user type." unless users.empty?
    end

end
