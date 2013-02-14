class ExpenseAttachment < ActiveRecord::Base
  # Attributes
  attr_accessible :description,
                  :expense_id,
                  :file_path
                  
  # Associations
  belongs_to :expense
   
  # Validations
  validates :description, presence: true, length: { maximum: 40 }
  validates :expense_id, presence: true
  validates :file_path, presence: true

  # Uploader
  mount_uploader :file_path, ExpenseAttachmentUploader               
end