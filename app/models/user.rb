class User < ActiveRecord::Base
  attr_accessible :company_id, :email, :manager_id, :name,
                  :user_type_id, :password, :password_confirmation
  has_secure_password

  default_scope :order => 'name'

  validates :company_id, :presence => true
  validates :name, :presence => true
  validates :email, :presence => true, uniqueness: { case_sensitive: false }
  validates :user_type_id, :presence => true
  validates_uniqueness_of :name, :scope => :company_id
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  belongs_to :company
  belongs_to :manager, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :user_type

  has_many :users, :foreign_key => "manager_id"
  has_many :expenses

  before_save { self.email.downcase! }
  before_save :create_remember_token

  before_destroy :ensure_not_referenced_by_any_user
  before_destroy :ensure_not_referenced_by_any_expense

  after_destroy :ensure_an_admin_remains
 
  def manager_name
    if (manager.nil?)
      return ""
    else
      return manager.name
    end
  end


  def ensure_an_admin_remains
    if user_type_id == UserType::admin_id
      if User.where("user_type_id = :admin_id and company_id = :company_id",
       { :admin_id => UserType::admin_id, :company_id => company_id }).count.zero?
        raise "Can't delete last admin"
      end
    else
      if user_type_id == UserType::vendor_admin_id
        if User.where("user_type_id = :vendor_admin_id and company_id = :company_id",
         { :vendor_admin_id => UserType::vendor_admin_id, :company_id => Company::vendor_id }).count.zero?
          raise "Can't delete last vendor admin"
        end
      end
    end
  end

  private

    # ensure that there are no users referencing this user as a manager
    def ensure_not_referenced_by_any_user
      if users.empty?
        return true
      else
        errors.add(:base, 'There are users referencing this user as a manager')
        return false
      end
    end

    # ensure that there are no expenses referencing this user
    def ensure_not_referenced_by_any_expense
      if expenses.empty?
        return true
      else
        errors.add(:base, 'There are expenses referencing this user')
        return false
      end
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
