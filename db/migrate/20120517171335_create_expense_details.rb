class CreateExpenseDetails < ActiveRecord::Migration
  def change
    create_table :expense_details do |t|
      t.integer :expense_id, :null => false
      t.integer :expense_type_id, :null => false
      t.date :date, :null => false
      t.integer :currency_id, :null => false
      t.decimal :amount, :null => false
      t.decimal :exchange_rate, :precision => 8, :scale => 2, :null => false
      t.text :comments

      t.timestamps
    end
  end
end
