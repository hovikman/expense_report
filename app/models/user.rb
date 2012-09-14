class User < ActiveRecord::Base
  has_secure_password

  # Attributes
  attr_accessible :company_id,
                  :email,
                  :manager_id,
                  :name,
                  :password,
                  :password_confirmation,
                  :user_type_id

  # Scope
  default_scope :order => 'name'

  # Associations
  has_many :users, :foreign_key => "manager_id"
  has_many :expenses
  has_many :owned_expenses, :class_name => "Expense", :foreign_key => :owner_id
  belongs_to :company
  belongs_to :manager, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :user_type

  # Validations
  validates :company_id, :presence => true
  validates :name, :presence => true
  validates :email, :presence => true, uniqueness: { case_sensitive: false }
  validates :user_type_id, :presence => true
  validates_uniqueness_of :name, :scope => :company_id
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validate :validate_user_type

  # Callbacks
  before_save { self.email.downcase! }
  before_save :create_remember_token
  before_destroy :ensure_not_referenced_by_any_user
  before_destroy :ensure_not_referenced_by_any_expense
  after_destroy :ensure_an_admin_remains
  after_update  :ensure_an_admin_remains

  # Methods
  def vendor_admin?
    user_type_id == UserType.vendor_admin_id
  end

  def regular_user?
    user_type_id == UserType.regular_user_id
  end

  def company_admin?
    user_type_id == UserType.admin_id
  end

  def admin?
    vendor_admin? || company_admin?
  end

  def guest?
    !regular_user? && !admin?
  end
 
  def manager_name
    if (manager.nil?)
      return ""
    else
      return manager.name
    end
  end

  def name_with_company
     "#{name}, #{company.name}"
  end
  
  def validate_user_type
    if company_id != Company::vendor_id
      if user_type_id == UserType::vendor_admin_id
        errors.add(:user_type_id, "can be 'Vendor Administrator' only for vendor company")
      end
    end
  end

  def ensure_an_admin_remains
    if user_type_id == UserType::admin_id
      if User.where({user_type_id: UserType::admin_id, company_id: company_id}).count.zero?
         raise "Cannot delete last admin."
      end
    else
      if user_type_id == UserType::vendor_admin_id
        if User.where({user_type_id: UserType::vendor_admin_id, company_id: company_id}).count.zero?
          raise "Cannot delete last vendor admin."
        end
      end
    end
  end

  private

    # ensure that there are no users referencing this user as a manager
    def ensure_not_referenced_by_any_user
      raise "Cannot delete user '#{name}'. There are users referencing this user as manager." unless users.empty?
    end

    # ensure that there are no expenses referencing this user
    def ensure_not_referenced_by_any_expense
      raise "Cannot delete user '#{name}'. There are expenses referencing this user." unless expenses.empty?
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end