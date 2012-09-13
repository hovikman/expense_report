class CreateExpenseStatuses < ActiveRecord::Migration
  def change
    create_table :expense_statuses do |t|
      t.string :name, :limit => 25, :null => false

      t.timestamps
    end
  end
end
