class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id, :null => false
      t.date :submit_date, :null => false
      t.text :purpose, :null => false
      t.integer :expense_status_id, :null => false
      t.decimal :advance_pay, :precision => 8, :scale => 2, :null => false

      t.timestamps
    end
  end
end
