class CreateExpenseAttachments < ActiveRecord::Migration
  def change
    create_table :expense_attachments do |t|
      t.integer :expense_id, :null => false
      t.string :description, :limit => 40, :null => false
      t.string :file_path, :null => false

      t.timestamps
    end
  end
end
