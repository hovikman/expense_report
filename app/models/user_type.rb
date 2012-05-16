class UserType < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true

  has_many :users

  before_destroy :ensure_not_referenced_by_any_user

  attr_accessible :name

  # constants for predefined user type values
  ADMIN_STR        = "Administrator"
  REGULAR_USER_STR = "Regular User"
  VENDOR_ADMIN_STR = "Vendor Administrator"

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
      if users.empty?
        return true
      else
        errors.add(:base, 'There users referencing this user_type')
        return false
      end
    end

end
