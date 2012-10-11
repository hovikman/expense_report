class AddIndexToExpenseAttachmentsExpenseId < ActiveRecord::Migration
  def change
    add_index :expense_attachments, :expense_id
  end
end
