class AddAccountantToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :accountant_id, :int
  end
end
