class AddIndices < ActiveRecord::Migration
  def change
    add_index :companies, :name, unique: true
    add_index :currencies, :code, unique: true
    add_index :currencies, :name, unique: true
    add_index :expense_details, [:expense_id, :date], order: {expense_id: :asc, date: :desc}
    add_index :expense_types, [:company_id, :name], unique: true
    add_index :expenses, :user_id
    add_index :expenses, :owner_id
    add_index :users, [:company_id, :name], unique: true
  end
end
