class ReplaceExpenseOwner
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :company_id, :from_user_id, :to_user_id

  validates :company_id, presence: true
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validate :validate_user_ids
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def validate_user_ids
    if from_user_id != '' and (from_user_id == to_user_id)
      errors.add :base, "From user and To user cannot be the same."
    end
  end

end