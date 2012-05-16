class Company < ActiveRecord::Base
  default_scope :order => 'name'

  validates :name, :presence => true, :uniqueness => true
  validates :tag, :presence => true, :uniqueness => true
  validates :currency_id, :presence => true
  validates :contact_person, :presence => true
  validates :contact_title, :presence => true
  validates :contact_phone, :presence => true
  validates :contact_email, :presence => true

  belongs_to :currency
  has_many :users

  before_destroy :ensure_not_referenced_by_any_user

  attr_accessible :contact_email, :contact_person, :contact_phone, :contact_title, :currency_id, :name, :tag

  # constants for name and tag of the vendor
  VENDOR_NAME_STR = "Vendor"
  VENDOR_TAG_STR  = "vendor"

  def self.vendor_id
    find_by_name(VENDOR_NAME_STR).id
  end
 
  private

    # ensure that there are no users referencing this company
    def ensure_not_referenced_by_any_user
      if users.empty?
        return true
      else
        errors.add(:base, 'There users referencing this company')
        return false
      end
    end

end
