class CreateExpenseTypes < ActiveRecord::Migration
  def change
    create_table :expense_types do |t|
      t.string :name, :limit => 30, :null => false
      t.integer :company_id, :null => false

      t.timestamps
    end
  end
end
