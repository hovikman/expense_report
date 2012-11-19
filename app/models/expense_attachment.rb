class ExpenseAttachment < ActiveRecord::Base
  # Attributes
  attr_accessible :description,
                  :expense_id,
                  :file_path
                  
  # Scopes
  scope :for_datatable, select('expense_attachments.id, expense_attachments.description') 

  # Associations
  belongs_to :expense
   
  # Validations
  validates :description, presence: true
  validates :file_path, presence: true

  # Uploader
  mount_uploader :file_path, ExpenseAttachmentUploader               
end