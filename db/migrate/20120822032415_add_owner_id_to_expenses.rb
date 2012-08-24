class AddOwnerIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :owner_id, :int
  end
end
