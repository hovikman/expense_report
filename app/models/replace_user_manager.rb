class ReplaceUserManager
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  # Attributes
  attr_accessor :company_id,
                :manager_id,
                :new_manager_id

  # Validations
  validates :company_id, presence: true
  validate :validate_manager_ids
  
  # Methods
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def validate_manager_ids
    if (manager_id == '') and (new_manager_id == '')
      errors.add :base, "The manager and new manager both can't be blank."  
    elsif manager_id == new_manager_id
      errors.add :base, "The manager and new manager cannot be the same."
    end 
  end
end