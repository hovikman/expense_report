class ReplaceExpenseOwner
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  # Attributes
  attr_accessor :company_id,
                :owner_id,
                :new_owner_id

  # Validations
  validates :company_id, presence: true
  validates :owner_id, presence: true
  validates :new_owner_id, presence: true
  validate :validate_owner_ids
  
  # Methods
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def validate_owner_ids
    if owner_id != '' and (owner_id == new_owner_id)
      errors.add :base, "The owner and new owner can't be the same."
    end
  end

end